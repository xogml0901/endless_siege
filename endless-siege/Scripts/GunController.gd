extends Node2D
class_name GunController

#fire은 main_gun으로만 이루어짐
var main_gun: Gun = null
var sub_gun: Gun = null

@export var bullet_holder: Node2D

#UI
@onready var ammo_manager: AmmoBarManager = $"../UI/AmmosUI"
@onready var status_ui: StatusUI = $"../UI/StatusUI"

#func _ready() -> void:
	#var base_gun: Gun = preload("uid://b1nyje4la40w2").instantiate()
	#equip_gun(base_gun)
	#add_child(base_gun)

func _input(event: InputEvent):
	if event.is_action_pressed("fire"):
		fire()
		
	if event.is_action_pressed("swap"):
		swap()

func equip_gun(gun: Gun):
	if !main_gun:
		main_gun = gun
		main_gun.reparent(self)
		main_gun.equip(bullet_holder, ammo_manager)
		ammo_manager.update_bar(main_gun)
		status_ui.main_gun_texture.texture = main_gun.gun_icon
	else:
		if !sub_gun:
			sub_gun = gun
			sub_gun.reparent(self)
			sub_gun.equip(bullet_holder, ammo_manager)
			sub_gun.hide()
			status_ui.sub_gun_texture.texture = sub_gun.gun_icon
		else:
			print("exchange")
			return

func fire():
	if !main_gun: return
	if !main_gun.fireable: return
	main_gun.fire()

func swap():
	if !main_gun || !sub_gun: return
	
	var temp_gun: Gun = main_gun
	main_gun = sub_gun
	sub_gun = temp_gun
	
	sub_gun.swap_gun()
	main_gun.show()
	sub_gun.hide()
	
	status_ui.main_gun_texture.texture = main_gun.gun_icon
	status_ui.sub_gun_texture.texture = sub_gun.gun_icon
	
	ammo_manager.update_bar(main_gun)
