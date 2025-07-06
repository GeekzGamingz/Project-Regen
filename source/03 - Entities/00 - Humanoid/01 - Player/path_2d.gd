extends Path2D


func _physics_process(_delta: float) -> void:
	var mouse_position = get_local_mouse_position()
	var range_arc = mouse_position.x / PI
	curve.set_point_position(1, mouse_position)
	curve.set_point_out(0, Vector2(range_arc, -range_arc))
	curve.set_point_in(1, Vector2(-range_arc, -range_arc))
