extends Bullet
class_name PhantomBullet

var phantom: Phantom

func init(gun: Gun):
	current_penetration_count = 0
	phantom = gun

func set_damage():
	if phantom.shot_stack <= 1:
		can_penetrate = false
		damage = Global.player.stat.attack * 1.2
	elif phantom.shot_stack == 2:
		can_penetrate = true
		damage = Global.player.stat.attack * 1.5
		phantom.shot_stack = 0
	else:
		can_penetrate = true
		damage = Global.player.stat.attack * 1.5
		phantom.shot_stack = 0
