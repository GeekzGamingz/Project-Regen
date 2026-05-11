extends Node2D
#------------------------------------------------------------------------------#
#Variables
@onready var input: Node2D = $"../../Player_Input"
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var HOTBAR: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Hotbar")
#------------------------------------------------------------------------------#
#Functions
#Custom Functions
#Object Interaction
func interact_object() -> void:
	for o in input.object_detection.get_children(): #Detect Raycasts
		if o.is_colliding():
			var object = o.get_collider().get_node("../..")
			check_slots(object)
			var hotbar_selected = HOTBAR.hotbar_array[HOTBAR.hotbar_selection]
			object.rpc("interact")
			if object.is_obtainable: obtain_object(object, hotbar_selected)
			break #Break Raycast Loop
#Check Duplicate Item
func check_slots(object):
	for slot in HOTBAR.hotbar_array:
		if slot.contents != "Empty":
			if slot.contents.contains(object.get_groups()[0]):
				HOTBAR.scroll_hotbar(slot.name)
				break #Break Slot Check
			else: find_slot()
#Search for Empty Slot
func find_slot():
	for slot in HOTBAR.hotbar_array:
		if slot.name != HOTBAR.hotbar_array[HOTBAR.hotbar_selection].name: continue
		else:
			if slot.contents == "Empty":
				HOTBAR.scroll_hotbar(slot.name)
				break #Break Find Slot
			else: HOTBAR.scroll_hotbar("Next")
#Obtain Object
func obtain_object(object, hotbar_selected):
	if hotbar_selected.is_empty: addto_hotbar(object, hotbar_selected)
	else:
		var group = object.get_groups()
		if hotbar_selected.held_item.is_in_group(group[0]):
			if object.is_stackable: hotbar_selected.quantity += 1
	object.queue_free()
#Add to Hotbar
func addto_hotbar(object, hotbar_selected):
	hotbar_selected.is_empty = false
	hotbar_selected.quantity += 1
	hotbar_selected.texture_object.texture = object.sprite_hotbar.texture
	var object_scene = object.duplicate()
	hotbar_selected.held_item = object_scene
