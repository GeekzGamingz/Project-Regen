extends Node2D
#------------------------------------------------------------------------------#
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var entity: Node2D = get_parent().get_parent()
#------------------------------------------------------------------------------#
#Custom Functions
#Handle Movement Provided By Player
func handle_movement() -> void:
	entity.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if entity.direction != Vector2.ZERO: MAIN.CAMERA_MAIN.position = entity.position
