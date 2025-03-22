extends CharacterBody2D
class_name PlayerController

enum Direction { LEFT, RIGHT, UP, DOWN }
enum State { IDLE, RUN }

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gun: GunController = $GunController

var direction = Direction.DOWN
var state = State.IDLE

var stat: PlayerStat = PlayerStat.new()

func _init():
	Global.player = self

func _process(delta):
	update_direction()
	update_animation()
	update_state(delta)
	
	move_and_slide()

func update_direction():
	var mouse_pos = get_global_mouse_position()
	var node_pos = global_position

	if abs(mouse_pos.x - node_pos.x) > abs(mouse_pos.y - node_pos.y):
		direction = Direction.LEFT if mouse_pos.x < node_pos.x else Direction.RIGHT
	else:
		direction = Direction.UP if mouse_pos.y < node_pos.y else Direction.DOWN

func update_state(delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity.x = move_toward(velocity.x, 125 * direction.x, 1400 * delta)
		velocity.y = move_toward(velocity.y, 125 * direction.y, 1400 * delta)
		state = State.RUN
	else:
		velocity.x = move_toward(velocity.x, 20 * direction.x, 1000 * delta)
		velocity.y = move_toward(velocity.y, 20 * direction.y, 1000 * delta)
		state = State.IDLE
		
func update_animation():
	match direction:
		Direction.LEFT:
			if state == State.IDLE:
				animation_player.play("idle_left")
			elif state == State.RUN:
				animation_player.play("run_left")
			return
		Direction.RIGHT:
			if state == State.IDLE:
				animation_player.play("idle_right")
			elif state == State.RUN:
				animation_player.play("run_right")
			return
		Direction.UP:
			if state == State.IDLE:
				animation_player.play("idle_up")
			elif state == State.RUN:
				animation_player.play("run_up")
			return
		Direction.DOWN:
			if state == State.IDLE:
				animation_player.play("idle_down")
			elif state == State.RUN:
				animation_player.play("run_down")
			return
