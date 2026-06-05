extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Bools
var mouse_hovering: bool = false
var slot_occupied: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var selection_held: NinePatchRect = $NPR_Held
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void: update_slot()
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if mouse_hovering:
		if event.is_action_pressed("action_confirm"):
			var cursor_grid = MAIN.UI_CURSOR_OBJECT.get_node("GridContainer")
			for selection in cursor_grid.get_children():
				var ray = selection.get_node("RayCast2D")
				if ray.is_colliding(): print(ray.get_collider())
#------------------------------------------------------------------------------#
#Signaled Functions
#Slot Entered
func _on_slot_entered() -> void:
	mouse_hovering = true
	selection_held.set_deferred("visible", true)
	print("Entered Backpack Slot: ", name)
#Slot Exited
func _on_slot_exited() -> void:
	mouse_hovering = false
	selection_held.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Functions
#Update Slot
func update_slot():
	if !slot_occupied: selection_held.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
	else: selection_held.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
	
