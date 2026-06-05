extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Bools
var mouse_hovering: bool = false
#OnReady Variables
@onready var selection_held: NinePatchRect = $NPR_Held
#------------------------------------------------------------------------------#
#Signaled Functions
#Slot Entered
func _on_slot_entered() -> void:
	mouse_hovering = true
	selection_held.set_deferred("visible", true)
	print(name)
#Slot Exited
func _on_slot_exited() -> void:
	mouse_hovering = false
	selection_held.set_deferred("visible", false)
