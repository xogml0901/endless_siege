extends ShotEffect
class_name TestEffect

var max_stack: int = 3

var current_stack: int

func _init():
	current_stack = 0

func execute():
	current_stack += 1
	if max_stack <= current_stack:
		current_stack = 0
