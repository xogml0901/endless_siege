extends RigidBody2D
class_name Dimention

@onready var collision: CollisionShape2D = $CollisionShape2D

func _process(delta: float):
	linear_velocity = transform.x * 35
	
func on_dimention():
	process_mode = Node.PROCESS_MODE_INHERIT
	show()	

func off_dimention():
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()
