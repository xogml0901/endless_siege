extends Skill
class_name DimensionShift

var hoding_time: float = 15
var is_create: bool = false

var player: PlayerController
var dimention: Dimention

func _init(player: PlayerController):
	name = "Dimension Shift"
	desc = "Dimension Shift"
	texture = preload("res://Assets/Skill Icon/76.png")
	cooldown = 20
	
	self.player = player
	instantiate_dimention()
	
func instantiate_dimention():
	var dimention_scene: PackedScene = preload("res://Scenes/Skill/dimension_shift.tscn")
	dimention = dimention_scene.instantiate()
	player.get_tree().root.add_child.call_deferred(dimention)
	dimention.off_dimention()

func execute():
	if player == null: return
	if !is_create:
		dimention.global_position = player.gun.global_position
		dimention.rotation = player.gun.rotation
		dimention.on_dimention()
		is_create = true
	else:
		player.global_position = dimention.global_position
		dimention.off_dimention()
		is_create = false
		
