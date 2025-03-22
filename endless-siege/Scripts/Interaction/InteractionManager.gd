extends Node2D
class_name InteractionManager

@onready var interact_label = $Label
@onready var gun_controller = $"../GunController"

var interactable_areas: Array[InteractionArea] = []
var can_interact: bool = true

func _input(event: InputEvent):
	if event.is_action_pressed("Interact") and can_interact:
		if interactable_areas:
			can_interact = false
			interact_label.hide()
			
			var vaild_index: int = interactable_areas.find_custom(find_interactable_area.bind())
			if vaild_index != -1:
				await interactable_areas[vaild_index].interact.call()
			
			can_interact = true

func find_interactable_area(area: InteractionArea):
	return area.interactable == true

func _process(delta: float):
	if interactable_areas and can_interact:
		interactable_areas.sort_custom(sort_by_nearest)
		if interactable_areas[0].interactable:
			interact_label.text = interactable_areas[0].interaction_name
			interact_label.global_position = interactable_areas[0].text_point.global_position
			interact_label.show()
	else:
		interact_label.hide()

func sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: InteractionArea):
	interactable_areas.push_back(area)
	area.enter.call()

func _on_interact_range_area_exited(area: InteractionArea):
	interactable_areas.erase(area)
	area.exit.call()
