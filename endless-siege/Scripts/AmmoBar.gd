extends ProgressBar
class_name AmmoBar

var active: bool = false
var is_load: bool
var next_bar: AmmoBar

func set_bar():
	value = 0

func update_progress(progress: float):
	value += progress

func set_max_value(value: float):
	max_value = value
	
func complete_load():
	value = max_value

func set_is_load_false(current_value: float):
	is_load = false
	value = current_value
	if next_bar.active:
		next_bar.value = 0

func set_is_load_true():
	is_load = true
	value = max_value
