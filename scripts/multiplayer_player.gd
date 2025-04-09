extends CharacterBody2D

const SPEED = 300.0

@export var player_id: int = 1:
	set(id):
		player_id = id

func _apply_movement_from_input(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	print(player_id)
	print(x_direction)
	print(y_direction)
	
	velocity.x = x_direction * SPEED
	velocity.y = y_direction * SPEED
	
	move_and_slide()

func _physics_process(delta):
	if multiplayer.is_server():
		_apply_movement_from_input(delta)
