extends HFlowContainer
class_name AmmoBarManager

@export var ammo_bar: PackedScene
@export var ammo_bars: Array[AmmoBar] = []

var max_ammo_bars: int = 10 
var reload_time: float

func _ready() -> void:
	for i in range(max_ammo_bars):
		var new_bar: AmmoBar = ammo_bar.instantiate()
		new_bar.hide()
		new_bar.active = false
		add_child(new_bar)
		ammo_bars.append(new_bar)
		if i != 0:
			ammo_bars[i - 1].next_bar = new_bar

func find_first_incomplete_bar() -> AmmoBar:
	for bar in ammo_bars:
		if bar.value < bar.max_value:
			return bar
	return null

func update_bar(gun: Gun):
	for i in range(max_ammo_bars):
		if i < gun.max_ammo:
			ammo_bars[i].show()
			ammo_bars[i].max_value = gun.reload_time
			if i < gun.current_ammo:
				ammo_bars[i].value = ammo_bars[i].max_value
			else:
				if i == gun.current_ammo:
					ammo_bars[i].value = gun.current_reload_time
				else:
					ammo_bars[i].value = 0
					
			reload_time = gun.reload_time
			ammo_bars[i].active = true
		else:
			if i < ammo_bars.size():
				ammo_bars[i].hide()
				ammo_bars[i].active = false
