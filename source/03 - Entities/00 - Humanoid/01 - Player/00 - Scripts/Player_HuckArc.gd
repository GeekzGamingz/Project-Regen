extends Path2D
#------------------------------------------------------------------------------#
#Functions
func _physics_process(_delta: float) -> void: huck_arc()
#Custom Functions
func huck_arc() -> void:
	var mouse_position = get_local_mouse_position()
	var range_arc = mouse_position.x / PI
	curve.set_point_position(1, mouse_position)
	if mouse_position.x  >= 0:
		curve.set_point_out(0, Vector2(range_arc, -range_arc))
		curve.set_point_in(1, Vector2(-range_arc, -range_arc))
	else:
		curve.set_point_out(0, Vector2(range_arc, range_arc))
		curve.set_point_in(1, Vector2(-range_arc, range_arc))
