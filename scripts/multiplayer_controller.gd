extends CharacterBody2D

const SPEED = 300.0

var x_direction
var y_direction

@export var player_id: int = 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(player_id)
		
func _ready() -> void:
	if multiplayer.get_unique_id() == player_id:
		$Camera2D.make_current()
	else:
		$Camera2D.enabled = false

func _apply_movement_from_input(delta):
	x_direction = %InputSynchronizer.input_direction_x
	y_direction = %InputSynchronizer.input_direction_y
	
	velocity.x = x_direction * SPEED
	velocity.y = y_direction * SPEED
	move_and_slide()
	
func _physics_process(delta):
	if multiplayer.is_server():
		_apply_movement_from_input(delta)
