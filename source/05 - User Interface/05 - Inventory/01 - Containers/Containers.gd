extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
#Bools
var mouse_hovering: bool = false
#OnReady Variables
@export var compartment_array: Array[HBoxContainer]
#------------------------------------------------------------------------------#
#Signaled Functions
#Close Button
func _on_close_button_up() -> void: set_deferred("visible", false)
#Mouse Detection
func _on_mouse_entered() -> void: mouse_hovering = true
func _on_mouse_exited() -> void: mouse_hovering = false
