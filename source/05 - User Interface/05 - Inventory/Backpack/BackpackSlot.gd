extends TextureRect


@onready var selection_held: NinePatchRect = $NPR_Held


var mouse_hovering: bool = false


	


func _on_slot_entered() -> void:
	mouse_hovering = true
	selection_held.set_deferred("visible", true)
	print(name)

func _on_slot_exited() -> void:
	mouse_hovering = false
	selection_held.set_deferred("visible", false)
