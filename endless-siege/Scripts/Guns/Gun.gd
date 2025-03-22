extends Node2D
class_name Gun

@export var gun_name: String
@export var gun_desc: String
@export var max_ammo: int
@export var bullet_scene: PackedScene
@export var fire_rate: float
@export var reload_time: float
@export var rebound_force: float = 4

var current_ammo: int
var current_reload_time: float
var time_since_last_fire: float
var fireable: bool

var bullet_holder: Node2D
var ammo: AmmoBarManager

var is_equip: bool
var can_equip: bool #in range

@onready var sprite: Sprite2D = $Sprite2D
@onready var fire_point: Node2D = $Marker2D
@onready var interaction: InteractionArea = $Interaction

@onready var fire_particle: GPUParticles2D = $FireParticle
#@onready var highlight: ColorRect = $Control/ColorRect

@export var gun_icon: Texture2D

signal end_fire

func _init():
	reload_time = 2
	max_ammo = 3
	fire_rate = 0.2
	
func _ready():
	interaction.interact = on_interact
	interaction.enter = on_enter
	interaction.exit = on_exit

func _process(delta: float):
	if !is_equip: return
	update_aim()
	time_to_refire(delta)
	reload_ammo(delta)

func equip(holder: Node2D, ammo_manager: AmmoBarManager):
	interaction.interactable = false
	bullet_holder = holder
	ammo = ammo_manager
	current_ammo = max_ammo
	current_reload_time = 0
	time_since_last_fire = 0
	is_equip = true
	position = Vector2(0, 0)
	sprite.material.set_shader_parameter("onoff",0)
	#highlight.hide()

func unequip():
	interaction.interactable = true
	is_equip = false

func update_aim():
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func fire() -> bool:
	if current_ammo <= 0 || !fireable: return false
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = fire_point.global_position
	bullet.rotation = rotation
	bullet.init(self)
	bullet.on_hit.connect(on_bullet_hit)
	apply_shot_effect_to_bullet(bullet)
	get_tree().root.add_child(bullet)
	
	play_fire_particle()
	on_fire()
	rebound()
	
	current_ammo -= 1
	fireable = false
	time_since_last_fire = 0
	ammo.ammo_bars[current_ammo].set_is_load_false(current_reload_time)
	return true

func on_fire():
	pass
	
func on_bullet_hit():
	pass

func apply_shot_effect_to_bullet(bullet: Bullet): # << virtual
	pass

func swap_gun():
	pass

func time_to_refire(delta: float):
	if fireable: return
	time_since_last_fire += delta
	if time_since_last_fire >= fire_rate:
		fireable = true
		time_since_last_fire = 0
		
func reload_ammo(delta: float):
	if fireable == false: return
	if current_ammo >= max_ammo: return
	current_reload_time += delta
	ammo.ammo_bars[current_ammo].value = current_reload_time
	if current_reload_time >= reload_time:
		current_ammo += 1
		current_reload_time = 0
		ammo.ammo_bars[current_ammo - 1].set_is_load_true()
		#print("add ammo => ", current_ammo)

func play_fire_particle():
	if !fire_particle: return
	fire_particle.restart()
	fire_particle.emitting = true
	
func rebound():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	var initial_position = sprite.position
	var direction = get_global_mouse_position() - initial_position
	direction.y = 0
	
	var recoil_target_position = initial_position - direction.normalized() * rebound_force
	
	tween.tween_property(sprite, "position", recoil_target_position, 0.1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "position", initial_position, 0.1).set_ease(Tween.EASE_OUT).set_delay(0.1)
		
func on_interact():
	Global.player.gun.equip_gun(self)

func on_enter():
	if is_equip: return
	sprite.material.set_shader_parameter("onoff",1)

func on_exit():
	if is_equip: return
	sprite.material.set_shader_parameter("onoff",0)
