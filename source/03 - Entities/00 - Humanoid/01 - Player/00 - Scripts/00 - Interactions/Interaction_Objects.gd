extends Node2D
#------------------------------------------------------------------------------#
#Variables
var current_object: Node2D = null
var hands_origin: TextureRect = null
var full_hotbar: bool = false
var full_hands: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var ORPHANAGES_OBJECTS: Node2D = MAIN.get_node("World/Orphanages/Orphanage_Objects")
@onready var HOTBAR: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Hotbar")
#Local Nodes
@onready var input: Node2D = $"../../Player_Input"
#------------------------------------------------------------------------------#
#Functions
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_confirm"):
		if current_object != null: drop(current_object, hands_origin)
	if event.is_action_pressed("action_context"): cancel(current_object)
#------------------------------------------------------------------------------#
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
	var slots_filled = 0
	for slot in HOTBAR.hotbar_array:
		if slot.contents != "Empty":
			slots_filled += 1
			if slot.contents.contains(object.get_groups()[0]):
				HOTBAR.scroll_hotbar(slot.name)
				break #Break Slot Check
			else: find_slot()
	full_hotbar = true if slots_filled == 12 else false
	if full_hotbar: print("FULL HOTBAR")
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
	var group = object.get_groups()
	if full_hands == false:
		if hotbar_selected.is_empty: addto_hotbar(object, hotbar_selected)
		if hotbar_selected.held_item.is_in_group(group[0]):
			if object.is_stackable: hotbar_selected.quantity += 1
		if full_hotbar: addto_hand(object, "Ground")
		ORPHANAGES_OBJECTS.remove_child(object)
#Add to Hotbar
func addto_hotbar(object, hotbar_selected):
	hotbar_selected.is_empty = false
	hotbar_selected.quantity += 1
	hotbar_selected.texture_object.texture = object.sprite_hotbar.texture
	var object_scene = object.duplicate()
	hotbar_selected.held_item = object_scene
	hands_origin = hotbar_selected
#Add to Hand
func addto_hand(object, hotbar_origin):
	full_hands = true
	MAIN.UI_CURSOR.icon_state = "HoldObject"
	MAIN.UI_CURSOR.object_held = object
	print("Added [", object, "]" , " to Hand from ", hotbar_origin)
	current_object = object
#Add to Backpack
func addto_backpack(object):
	full_hands = true
	print("Added ", object, " to Backpack")
#Drop
func drop(object, hotbar_origin):
	ORPHANAGES_OBJECTS.add_child(object)
	object.global_position = get_global_mouse_position()
	full_hands = false
	current_object = null
	print("Dropped [", object, "] at ", object.global_position)
	hotbar_origin.is_empty = true
	
#Cancel
func cancel(object):
	MAIN.UI_CURSOR.icon_state = "Default"
	print("Canceled Holding [", object, "]")
	full_hands = false
	current_object = null
