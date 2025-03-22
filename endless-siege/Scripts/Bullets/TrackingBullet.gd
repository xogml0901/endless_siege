extends Bullet
class_name TrackingBullet

var curve_intensity: float = 1.5
var target: Node2D = null
var start_pos: Vector2

func set_target(target):
	self.target = target

func set_intensity(value: float):
	curve_intensity = value

func _process(delta):
	if target and is_instance_valid(target):
		var direction = (target.global_position - global_position).normalized()
		var perpendicular = Vector2(-direction.y, direction.x) * curve_intensity
		var curved_direction = (direction + perpendicular).normalized()
		global_position += curved_direction * speed * delta
	else:
		global_position += Vector2.RIGHT * speed * delta
