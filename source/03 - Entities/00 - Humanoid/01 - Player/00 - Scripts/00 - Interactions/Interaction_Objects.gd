extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Object Interaction
func interact_object() -> void:
	for o in interaction.input.object_detection.get_children(): #Detect Raycasts
		if o.is_colliding():
			var object = o.get_collider().get_node("../..")
			interaction.interaction_hotbar.check_slots(object)
			var hotbar_selected = interaction.HOTBAR.hotbar_array[interaction.HOTBAR.hotbar_selection]
			object.rpc("interact")
			if object.is_obtainable: obtain_object(object, hotbar_selected)
			break #Break Raycast Loop
#Obtain Object
func obtain_object(object, hotbar_selected):
	var group = object.get_groups()
	if interaction.full_hands == false:
		if hotbar_selected.is_empty: interaction.interaction_hotbar.addto_hotbar(object, hotbar_selected)
		if hotbar_selected.slotted_item.is_in_group(group[0]):
			if object.is_stackable: hotbar_selected.quantity += 1
		if interaction.full_hotbar: addto_hand(object, null)
		interaction.ORPHANAGES_OBJECTS.remove_child(object)
#Add to Hand
func addto_hand(object, hotbar_origin):
	var cursor = interaction.MAIN.UI_CURSOR
	interaction.full_hands = true
	cursor.icon_state = "HoldObject"
	cursor.object_held = object
	interaction.current_object = object
	if hotbar_origin != null:
		if hotbar_origin.quantity > 0:
			cursor.quantity = hotbar_origin.quantity
			cursor.output_quantity.set_deferred("visible", true)
		hotbar_origin.slot_held.set_deferred("visible", true)
		interaction.hands_origin = hotbar_origin
		print("Added [", object.name, "]" , " to Hand from ", hotbar_origin.name)
	else:
		print("Added [", object.name, "]" , " to Hand from Ground")
		for slot in interaction.HOTBAR.hotbar_array:
			if slot.contents.contains(object.get_groups()[0]):
				interaction.revert()
				break
	
#Drop
func place(object, hotbar_origin, new_position):
	var dupe = object.duplicate()
	if hotbar_origin != null:
		hotbar_origin.slot_held.set_deferred("visible", false)
		if object.is_stackable && hotbar_origin.quantity > 1:
			hotbar_origin.quantity -= 1
		else: hotbar_origin.is_empty = true
	interaction.ORPHANAGES_OBJECTS.add_child(dupe)
	dupe.global_position = new_position
	interaction.revert()
	print("Dropped [", dupe.name, "] at ", dupe.global_position)
#Cancel
func cancel(object, hotbar_origin):
	if hotbar_origin != null:
		hotbar_origin.slot_held.set_deferred("visible", false)
	else:
		var player = interaction.get_node("../..")
		interaction.ORPHANAGES_OBJECTS.add_child(object)
		object.global_position = player.marker_drop.global_position
	interaction.revert()
	#print("Canceled Holding [", object.name, "]")
	
