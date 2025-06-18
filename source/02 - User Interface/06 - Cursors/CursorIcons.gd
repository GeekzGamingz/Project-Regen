extends Sprite2D
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
