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
			object.interact()
			if object.is_obtainable: obtain_object(object, hotbar_selected)
			break #Break Raycast Loop
#Obtain Object
func obtain_object(object, hotbar_selected):
	var group = object.get_groups()
	if interaction.full_hands == false:
		if hotbar_selected.slotted_object == null:
			interaction.interaction_hotbar.addto_hotbar(object, hotbar_selected)
		if hotbar_selected.slotted_object.is_in_group(group[0]):
			if object.is_stackable: hotbar_selected.quantity += 1
		if interaction.full_hotbar:
			interaction.MAIN.UI_INVENTORY.slot_exclusion(true)
			addto_hand("All", object, null)
			await get_tree().process_frame
			interaction.MAIN.UI_INVENTORY.slot_exclusion(false)
		if hotbar_selected.slotted_object.is_in_group(group[0]):
			if object.is_stackable: interaction.revert()
		interaction.ORPHANAGES_OBJECTS.remove_child(object)
#Add to Hand
func addto_hand(amount, object, origin):
	var cursor = interaction.MAIN.UI_CURSOR
	interaction.full_hands = true
	cursor.icon_state = "HoldObject"
	cursor.object_held = object
	interaction.current_object = object
	if origin != null:
		if origin.quantity > 0: match(amount):
			"All": cursor.quantity = origin.quantity
			"Half":
				if origin.quantity == 1: cursor.quantity = 1
				else:
					var half = floor(origin.quantity / 2)
					cursor.quantity += half
			"One": cursor.quantity += 1
		origin.slot_held.set_deferred("visible", true)
		interaction.hands_origin = origin
		print("Added [", cursor.quantity, " x ", object.name, "]" , " to Hand from ", origin.name)
	else:
		cursor.quantity = 1
		print("Added [", object.name, "]" , " to Hand from Ground")
#Place
func place(object, origin, new_position):
	var dupe = object.duplicate()
	if dupe.is_stackable:
		var stack = dupe.duplicate()
		var cursor = interaction.MAIN.UI_CURSOR
		interaction.ORPHANAGES_OBJECTS.add_child(stack)
		stack.global_position = new_position
		stack.name = object.name
		if cursor.object_held != null: cursor.quantity -= 1 #Drop Contingency
		if cursor.quantity == 0: #Reset Hand and Slot Held Only
			interaction.current_object = null
			interaction.full_hands = false
			cursor.icon_state = "Default"
			if origin != null: origin.slot_held.set_deferred("visible", false)
		if origin != null:
			origin.quantity -= 1
			if origin.quantity == 0:
				interaction.revert()
				origin.slotted_object = null
				interaction.full_hands = false
	else:
		interaction.ORPHANAGES_OBJECTS.add_child(dupe)
		print("Origin to Clear: ", origin)
		if origin != null: origin.clear_slot()
		interaction.revert()
		dupe.global_position = new_position
		dupe.name = object.name
	print("Dropped [", dupe.name, "] at ", dupe.global_position)
#Cancel
func cancel(object, origin):
	if origin != null:
		origin.object_highlight(false)
	else:
		var player = interaction.get_node("../..")
		interaction.ORPHANAGES_OBJECTS.add_child(object)
		object.global_position = player.marker_drop.global_position
	interaction.revert()
	print("Canceled Holding [", object.name, "]")
