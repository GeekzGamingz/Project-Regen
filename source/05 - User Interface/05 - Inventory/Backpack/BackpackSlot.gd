extends TextureRect



var mouse_hovering: bool = false



func _on_slot_entered() -> void: mouse_hovering = true

func _on_slot_exited() -> void: mouse_hovering = false
