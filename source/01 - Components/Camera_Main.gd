extends Camera2D
#------------------------------------------------------------------------------#
#Variables
#Bool Variables
var is_panning: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#------------------------------------------------------------------------------#
#Input Events
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_camera"):
		is_panning = true
		global_position = MAIN.BLUEPRINT.position
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if event.is_action_released("move_camera"):
		is_panning = false
		if !G.IS_BUILDING: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
