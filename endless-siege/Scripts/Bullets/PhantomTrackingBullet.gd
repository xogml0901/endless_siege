extends TrackingBullet
class_name PhantomTrackingBullet

func set_damage():
	damage = Global.player.stat.attack * 0.7
