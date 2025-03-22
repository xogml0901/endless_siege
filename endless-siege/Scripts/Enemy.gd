extends CharacterBody2D
class_name Enemy

@export var move_speed: float = 100.0

#move ai (test용)
@export var move_time: float = 0.5
var direction: Vector2 = Vector2.ZERO
var move_timer: float = 0.0

@onready var damage_text_point: Node2D = $DamageTextPoint
@onready var hit_particle: GPUParticles2D = $HitParticle

var shot_effects: Array[ShotEffect] = []

func _process(delta):
	move(delta)
	
func move(delta):
	move_timer -= delta
	if move_timer <= 0:
		set_random_direction()
	
	velocity = direction * move_speed
	move_and_slide()
	
func set_random_direction():
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	direction = directions[randi() % directions.size()]
	move_timer = move_time

func hit(damage: int, effects: Array[ShotEffect] = []):
	DamageNumber.display_number(damage, damage_text_point.global_position)
	Global.dps_manager.record_damage(damage)
	play_hit_particle()
	if !effects: return
	for effect in effects:
		var index: int = find_effect(effect)
		if index == -1: # 없던 효과라면
			shot_effects.append(effect)
			effect.execute()
		else:
			shot_effects[index].execute()

func find_effect(target_effect: ShotEffect) -> int:
	for i in range(shot_effects.size()):
		if shot_effects[i].name == target_effect.name:
			return i
	return -1

func play_hit_particle():
	if !hit_particle: return
	hit_particle.restart()
	hit_particle.emitting = true
