class_name PlayerSkill

var player: PlayerController

var first_skill: Skill
var second_skill: Skill
var third_skill: Skill

func _init(player: PlayerController):
	self.player = player
	first_skill = DimensionShift.new(player)
