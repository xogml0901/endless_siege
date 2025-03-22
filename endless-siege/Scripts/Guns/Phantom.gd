extends Gun
class_name Phantom

var shot_stack: int	# 0: 120%, 1: 150% and penetration
var tracking_stack: int 

@onready var tracking_bullet: PackedScene = preload("uid://dduvjmguptjde")
@onready var tracking_stack_label: Label = $TrackingStackLabel

var probability_add_tracking_stack: float = 0.5

func on_fire():
	shot_stack += 1

func on_bullet_hit():
	update_tracking_stack_on_hit()

func update_tracking_stack_on_hit():
	if tracking_stack >= 6: return
	if randf() < probability_add_tracking_stack:
		tracking_stack += 1
		tracking_stack_label.text = str(tracking_stack)

func swap_gun():
	if tracking_stack <= 0: return
	var target: Enemy = search_enemy()
	if !target or target == null: return
	
	var pos: Vector2 = Global.player.global_position
	
	for i in range(tracking_stack):
		var bullet: PhantomTrackingBullet = tracking_bullet.instantiate()
		bullet.global_position = pos
		bullet.set_target(target)
		bullet.set_intensity(randf_range(-2.0, 2.0))
		get_tree().root.add_child(bullet)
		
	tracking_stack = 0

func search_enemy() -> Enemy:
	var enemies: Array = get_tree().get_nodes_in_group("enemy")
	var shortest_enemy: Enemy
	if enemies:
		var shortest: float = global_position.distance_to(enemies[0].global_position)
		shortest_enemy = enemies[0]
		for i in enemies:
			var curr_dist: float = global_position.distance_to(i.global_position)
			if curr_dist < shortest:
				shortest_enemy = i
				shortest = curr_dist
				
	return shortest_enemy
