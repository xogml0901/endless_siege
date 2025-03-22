extends Area2D
class_name InteractionArea

@export var interaction_name: String = "interact"
@export var interactable: bool = true
@export var text_point: Node2D

var interact: Callable = func():
	pass

var enter: Callable = func():
	pass

var exit: Callable = func():
	pass
