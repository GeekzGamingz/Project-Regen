extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
#Bools
var mouse_hovering: bool = false
#OnReady Variables
@export var compartment_array: Array[HBoxContainer]
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: addto_dictionary()
#------------------------------------------------------------------------------#
#Signaled Functions
#Close Button
func _on_close_button_up() -> void: set_deferred("visible", false)
#Mouse Detection
func _on_mouse_entered() -> void: mouse_hovering = true
func _on_mouse_exited() -> void: mouse_hovering = false
#------------------------------------------------------------------------------#
func addto_dictionary():
	var new_name = str("Container", Items.CONTAINER_COUNT)
	name = new_name
	var slot_count = 0
	for compartment in compartment_array:
		for slot in compartment.get_node("TextureRect/GridContainer").get_children():
			if slot is TextureRect:
				slot_count += 1
				Items.SLOTS.set("Slot%s" % slot_count, slot)
	Items.CONTAINERS.set(new_name, Items.SLOTS.duplicate())
	Items.CONTAINER_COUNT += 1
	Items.SLOTS.clear()
	
