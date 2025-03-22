extends Gun
class_name TwoShotGun

func _init():
	gun_name = "TwoShotGun(Test)"
	gun_desc = "TwoShotGun(Test)"
	reload_time = 0.8
	max_ammo = 4
	fire_rate = 0.5
	bullet_scene = preload("uid://53con7s8llvv")
