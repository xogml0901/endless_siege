extends Node2D
class_name SkillBuilding

@onready var interactable: InteractionArea = $Interactable
@onready var sprite: Sprite2D = $Sprite2D
@onready var skill_ui = $"Skill Management"

func _ready():
	interactable.interact = on_interact

func on_interact():
	print("skill panel open")
