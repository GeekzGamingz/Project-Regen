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
		var object_path = NodePath(object.name)
		rpc("remove_placement", object_path)
#Remove from World
@rpc("any_peer", "call_local")
func remove_placement(object_path): interaction.ORPHANAGES_OBJECTS.get_node(object_path).queue_free()
#Add to Hand
func addto_hand(amount, object, origin):
	var object_index = object.index_name
	var native_object = Items.SCENES[object_index].instantiate()
	var cursor = interaction.MAIN.UI_CURSOR
	interaction.full_hands = true
	cursor.icon_state = "HoldObject"
	cursor.object_held = native_object
	interaction.current_object = native_object
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
		print("Added [", native_object.name, "]" , " to Hand from Ground")
#Place
func place(object, origin, new_position):
	var held_index = object.index_name
	print("Place Origin: ", origin)
	var native_origin: String
	var container_index: String
	var slot_index: String
	if origin != null:
		if origin.name.begins_with("Hotbar"): native_origin = "Hotbar"
		elif origin.name.begins_with("Slot"):
			native_origin = "Container" if origin.main_container.name != "Backpack" else "Backpack"
	else: native_origin = "Ground"
	match(native_origin):
		"Hotbar": origin.quantity -= 1
		"Backpack": for slot in origin.slot_array: slot.quantity -= 1
		"Container":
			container_index = origin.main_container.name
			slot_index = origin.name
		"Ground": print("Do Ground Stuff")
	rpc("update_placement", held_index, container_index, slot_index, new_position)
	if origin != null:
		if origin.quantity <= 0:
			interaction.revert()
			origin.slotted_object = null
			interaction.full_hands = false
	else: 
		interaction.revert()
		interaction.full_hands = false
#Update World Placement
@rpc("any_peer", "call_local")
func update_placement(held_index, container_index, slot_index, new_position):
	var object = Items.SCENES[held_index].instantiate()
	interaction.ORPHANAGES_OBJECTS.add_child(object)
	object.global_position = new_position
	if container_index != "":
		var native_slot = Items.CONTAINERS[container_index].get(slot_index)
		for slot in native_slot.slot_array:
			slot.quantity -= 1
		if native_slot.quantity <= 0:
			native_slot.slotted_object = null
	object.name = str("Object_", held_index)
	print("Dropped [", object.name, "] at ", object.global_position)
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
