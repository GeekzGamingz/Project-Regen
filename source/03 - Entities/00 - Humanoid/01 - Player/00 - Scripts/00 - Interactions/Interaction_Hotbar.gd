extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Check Duplicate object
func check_slots(object):
	var slots_filled = 0
	for slot in interaction.HOTBAR.hotbar_array:
		if slot.contents != "Empty":
			slots_filled += 1
			if slot.contents.contains(object.get_groups()[0]):
				interaction.HOTBAR.scroll_hotbar(slot.name)
				break #Break Slot Check
			else: find_slot()
	interaction.full_hotbar = true if slots_filled == 12 else false
	if interaction.full_hotbar: print("#-----FULL HOTBAR-----#")
#Search for Empty Slot
func find_slot():
	var hotbar = interaction.HOTBAR
	for slot in hotbar.hotbar_array:
		if slot.name != hotbar.hotbar_array[hotbar.hotbar_selection].name: continue
		else:
			if slot.contents == "Empty":
				hotbar.scroll_hotbar(slot.name)
				break #Break Find Slot
			else: hotbar.scroll_hotbar("Next")
#Combine Hotbar Items
func combine_slots(object, hotbar_selected):
	print("#---Combing Slots---#")
	print("Current Object: ", object)
	print("Current Hotbar Slot: ", hotbar_selected)
	var hotbar = interaction.HOTBAR
	for slot in hotbar.hotbar_array:
		var slotted_object = slot.slotted_object
		var selected_object = hotbar_selected.slotted_object
		if slotted_object != null && slotted_object.is_stackable && selected_object.is_stackable:
			print("Slotted Object Group: ", slotted_object.get_groups()[0])
			print("Selected Object Group: ", selected_object.get_groups()[0])
			if slotted_object.get_groups()[0].contains(selected_object.get_groups()[0]):
				if slot.quantity != 0 || hotbar_selected.quantity != 0:
					if slot != hotbar_selected:
						print("Selected Slot Quantity: ", hotbar_selected.quantity)
						print("Slot Quantity: ", slot.quantity)
						hotbar_selected.quantity += slot.quantity
						slot.slotted_object = null
					else: print("Slot Matched - Skipping Quantity Increase")
		slot.update_slot()
	print("#---Finished Combining---#")
#Add to Hotbar
func addto_hotbar(object, origin):
	origin.slotted_object = null
	origin.texture_object.texture = object.sprite_hotbar.texture
	var object_scene = object.duplicate()
	origin.slotted_object = object_scene
	combine_slots(object, origin)
#Trade Slots
func trade_slots(contents):
	var held_slot = check_held()
	var selected_slot = check_selection()
	var container_origin = interaction.interaction_containers.get_held()
	var cursor = interaction.MAIN.UI_CURSOR
	var held_quantity = cursor.quantity
	match(contents):
		"Empty":
			print("#---Trading Executed - Slot Empty---#")
			print("Held Object: ", interaction.current_object.name)
			if held_slot != null:
				print("Object Origin: ", held_slot.name)
				selected_slot.quantity = held_slot.quantity
				held_slot.slotted_object = null
			elif container_origin != null:
				print("Object Origin: Container [", container_origin, "]")
				container_origin.slot_primary.quantity -= cursor.quantity
				container_origin.object_highlight(false)
				selected_slot.quantity = held_quantity
				var new_quantity = container_origin.quantity
				var container_index = container_origin.main_container.name
				var slot_index = str("Slot " + container_origin.name.substr(4, -1))
				rpc("update_container_quantity", container_index, slot_index, new_quantity)
			else:
				print("Object Origin: Ground")
				selected_slot.quantity = held_quantity
			print("Slot Destination: ", selected_slot.name)
			addto_hotbar(interaction.current_object, selected_slot)
			interaction.revert()
		"Full":
			print("#---Trading Executed - Slot Occupied---#")
			print("Held Object: ", interaction.current_object.name)
			print("Slot Destination: ", selected_slot.name)
			print("Object Replacing: ", selected_slot.slotted_object.name)
			if held_slot != null:
				print("Slot Origin: ", held_slot.name)
				if held_slot == selected_slot:
					interaction.interaction_objects.cancel(
						interaction.current_object,
						held_slot
					) #Cancel if Selections Match
				else: #Trade Hotbar Object
					var trading_object = selected_slot.slotted_object
					var trading_texture = selected_slot.texture_object.texture
					var trading_quantity = selected_slot.quantity
					selected_slot.slotted_object = held_slot.slotted_object
					selected_slot.texture_object.texture = held_slot.texture_object.texture
					selected_slot.quantity = held_slot.quantity
					held_slot.slotted_object = trading_object
					held_slot.texture_object.texture = trading_texture
					held_slot.quantity = trading_quantity
					held_slot.slot_held.set_deferred("visible", false)
					interaction.revert()
			elif container_origin != null: #Trade Object from Container
				print("Object Origin: Container [", container_origin, "]")
				var trading_object = container_origin.slotted_object
				var slot_quantity = selected_slot.quantity
				interaction.interaction_objects.addto_hand(
					"All",
					selected_slot.slotted_object,
					null
				)
				container_origin.object_highlight(false)
				cursor.cursor_fsm.object_switch = true
				addto_hotbar(trading_object, selected_slot)
				await get_tree().process_frame
				selected_slot.quantity += held_quantity
				container_origin.quantity -= held_quantity
				cursor.quantity = slot_quantity
				if container_origin.quantity <= 0: container_origin.slotted_object = null
				interaction.revert()
				var new_quantity = container_origin.quantity
				var container_index = container_origin.main_container.name
				var slot_index = str("Slot " + container_origin.name.substr(4, -1))
				rpc("update_container_quantity", container_index, slot_index, new_quantity)
			else: #Trade Object from Ground
				print("Object Origin: Ground")
				var trading_object = interaction.current_object
				var trading_quantity = selected_slot.quantity
				interaction.interaction_objects.addto_hand(
					"All",
					selected_slot.slotted_object,
					null
				)
				cursor.cursor_fsm.object_switch = true
				selected_slot.quantity = held_quantity
				cursor.quantity = trading_quantity
				if cursor.quantity <= 1: cursor.quantity = 1
				addto_hotbar(trading_object, selected_slot)
	if !selected_slot.slotted_object.is_stackable: selected_slot.quantity = 0
	print("#---Finished Trading---#")
#Check for Selection
func check_selection():
	for slot in interaction.HOTBAR.slots_hotbar.get_children():
		if slot.slot_selected.visible == true: return slot
#Check for Held object
func check_held(): 
	for slot in interaction.HOTBAR.slots_hotbar.get_children():
		if slot.slot_held.visible == true: return slot
#Update Container Origin Quantity
@rpc("any_peer", "call_local")
func update_container_quantity(container_index, slot_index, quantity):
	var native_slot = Items.CONTAINERS[container_index].get(slot_index)
	for slot in native_slot.slot_array: native_slot.quantity = quantity
	if native_slot.quantity <= 0: native_slot.slotted_object = null
	print("Native Slot Array: ", native_slot.slot_array)
