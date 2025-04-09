extends MultiplayerSynchronizer

var input_direction_x
var input_direction_y

func _ready() -> void:
	
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
		
	input_direction_x = Input.get_axis("ui_left", "ui_right")
	input_direction_y = Input.get_axis("ui_up", "ui_down")

func _physics_process(delta: float) -> void:
	input_direction_x = Input.get_axis("ui_left", "ui_right")
	input_direction_y = Input.get_axis("ui_up", "ui_down")

func _process(delta: float) -> void:
	pass
