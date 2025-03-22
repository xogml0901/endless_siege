extends Control
class_name DPSManager

var total_dmg: float = 0.0
var total_time: int = 1.0
var current_time: float = 0.0
var current_reset_time = 0.0
var dps: float = 0.0

var on_meter: bool = false

@export var reset_time: float = 5.0

@onready var dps_label: Label = $dmg_label
@onready var time_label: Label = $time_label

func _ready() -> void:
	Global.dps_manager = self

func record_damage(amount: float):
	total_dmg += amount
	current_reset_time = 0
	if !on_meter: 
		on_meter = true
		time_label.text = "Time : " + str(total_time) + "s"

func _process(delta: float) -> void:
	if !on_meter: return
	current_time += delta
	current_reset_time += delta
	
	if current_time >= 1.0:
		total_time += 1
		current_time = 0
		time_label.text = "Time : " + str(total_time) + "s"
		
	if current_reset_time >= reset_time:
		on_meter = false
		total_time = 1.0
		current_reset_time = 0.0
		dps_label.text = "DPS : 0"
		time_label.text = "Time : 0s"
		return

	dps = total_dmg / total_time
	dps_label.text = "DPS : %.2f" % dps
