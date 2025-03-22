extends Node2D
class_name Bullet

var damage: int = 0
var shot_effects: Array[ShotEffect]
var current_penetration_count: int = 0

@export var speed: float = 500
@export var can_penetrate: bool = false
@export var max_penetration_count: int

signal end_fire
signal on_hit

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func init(gun: Gun):
	current_penetration_count = 0

func set_damage():
	pass

func hit():
	pass

func set_shot_effects(effects: Array[ShotEffect]):
	shot_effects.append_array(effects)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var enemy: Enemy = body as Enemy
		for effect in shot_effects:
			effect.set_target(enemy)
			
		set_damage()
		enemy.hit(damage, shot_effects)
		on_hit.emit()
		
		if can_penetrate:
			if max_penetration_count > current_penetration_count:
				return
			else:
				queue_free()
				
			current_penetration_count += 1
		else:
			queue_free()
			
		end_fire.emit()
		
	
