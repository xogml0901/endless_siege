extends Gun
class_name DeadShot

func _init():
	gun_name = "DeadShot"
	gun_desc = "damage : 300%"
	reload_time = 1.3
	max_ammo = 3
	fire_rate = 0.2
	rebound_force = 10

func apply_shot_effect_to_bullet(bullet: Bullet):
	var effects: Array[ShotEffect]
	effects.append(TestEffect.new())
	bullet.set_shot_effects(effects)
