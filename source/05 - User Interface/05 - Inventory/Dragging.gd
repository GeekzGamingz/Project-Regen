extends Control
#------------------------------------------------------------------------------#
#Variables
var dragPoint = null
#OnReady Variables
@onready var backpack: PanelContainer = $".."
#------------------------------------------------------------------------------#
#Functions
#Signaled Functions
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed: dragPoint = get_global_mouse_position() - backpack.get_position()
			else: dragPoint = null
	if event is InputEventMouseMotion && dragPoint != null:
		backpack.set_position(get_global_mouse_position() - dragPoint)
