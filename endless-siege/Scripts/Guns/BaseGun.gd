extends Gun
class_name BaseGun

func _init():
	gun_name = "Base Gun"
	gun_desc = "Base Gun"
	reload_time = 3.5
	max_ammo = 3
	fire_rate = 0.4
	bullet_scene = preload("uid://53con7s8llvv")
