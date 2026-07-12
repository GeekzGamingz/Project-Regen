extends Camera2D
#------------------------------------------------------------------------------#
#Variables
#Boolean Variables
var is_panning: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#------------------------------------------------------------------------------#
#Input Events
func _input(event: InputEvent) -> void:
	#Basic Panning
	if event.is_action_pressed("move_camera"):
		is_panning = true
		global_position = MAIN.BLUEPRINT.position
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if event.is_action_released("move_camera"):
		is_panning = false
		if !Globals.IS_BUILDING: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	#Basic Zoom (Shift to Three States)
	if event.is_action_pressed("zoom_in"): if zoom >= Vector2(0.3, 0.3): zoom -= Vector2(0.2, 0.2)
	if event.is_action_pressed("zoom_out"): if zoom <= Vector2(3, 3): zoom += Vector2(0.2, 0.2)
