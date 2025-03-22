extends Node

func display_number(value: int, position: Vector2, is_critical: bool = false):
	var number: Label = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	#print("damage_text_point.global_position: ", position)
	#print("number.global_position: ", number.global_position)
	
	var color = "#FFF"
	if is_critical:
		color = "B22"
	
	number.label_settings = LabelSettings.new()
	number.label_settings.font_color = color
	number.label_settings.font_size = 8
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 2
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 12, 0.15).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:y", number.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.15)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.3)
	
	await tween.finished
	number.queue_free()
