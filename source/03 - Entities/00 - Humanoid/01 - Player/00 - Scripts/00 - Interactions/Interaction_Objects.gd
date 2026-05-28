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
		if hotbar_selected.slotted_item == null: interaction.interaction_hotbar.addto_hotbar(object, hotbar_selected)
		if hotbar_selected.slotted_item.is_in_group(group[0]):
			if object.is_stackable: hotbar_selected.quantity += 1
		if interaction.full_hotbar: addto_hand("All", object, null)
		if hotbar_selected.slotted_item.is_in_group(group[0]):
			if object.is_stackable: interaction.revert()
		interaction.ORPHANAGES_OBJECTS.remove_child(object)
#Add to Hand
func addto_hand(amount, object, hotbar_origin):
	var cursor = interaction.MAIN.UI_CURSOR
	interaction.full_hands = true
	cursor.icon_state = "HoldObject"
	cursor.object_held = object
	interaction.current_object = object
	if hotbar_origin != null:
		if hotbar_origin.quantity > 1: match(amount):
			"All": cursor.quantity = hotbar_origin.quantity
			"Half":
				var half = floor(hotbar_origin.quantity / 2)
				hotbar_origin.quantity -= half
				cursor.quantity += half
			"One":
				cursor.quantity += 1
				hotbar_origin.quantity -= 1
		hotbar_origin.slot_held.set_deferred("visible", true)
		interaction.hands_origin = hotbar_origin
		print("Added [", cursor.quantity, " x ", object.name, "]" , " to Hand from ", hotbar_origin.name)
	else:
		print("Added [", object.name, "]" , " to Hand from Ground")
#Place
func place(object, hotbar_origin, new_position):
	var dupe = object.duplicate()
	if dupe.is_stackable:
		var stack = dupe.duplicate()
		interaction.ORPHANAGES_OBJECTS.add_child(stack)
		stack.global_position = new_position
		stack.name = object.name
		interaction.MAIN.UI_CURSOR.quantity -= 1
		if interaction.MAIN.UI_CURSOR.quantity == 0:
			interaction.current_object = null
		hotbar_origin.quantity -= 1
		if hotbar_origin.quantity == 0:
			interaction.revert()
			hotbar_origin.slotted_item = null
			interaction.full_hands = false
	else:
		interaction.ORPHANAGES_OBJECTS.add_child(dupe)
		if hotbar_origin != null: hotbar_origin.slotted_item = null
		interaction.revert()
		dupe.global_position = new_position
		dupe.name = object.name
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
	print("Canceled Holding [", object.name, "]")
	
