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
		if slotted_object != null && slotted_object.is_stackable:
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
	print("#---Finished Combining---#")
#Add to Hotbar
func addto_hotbar(object, hotbar_selected):
	hotbar_selected.slotted_object = null
	hotbar_selected.texture_object.texture = object.sprite_hotbar.texture
	var object_scene = object.duplicate()
	hotbar_selected.slotted_object = object_scene
	combine_slots(object, hotbar_selected)
#Trade Slots
func trade_slots(contents):
	var held_slot = check_held()
	var selected_slot = check_selection()
	match(contents):
		"Empty":
			print("#---Trading Executed - Slot Empty---#")
			print("Held Object: ", interaction.current_object.name)
			if held_slot != null:
				print("Object Origin: ", held_slot.name)
				selected_slot.quantity = held_slot.quantity
				held_slot.slotted_object = null
			else:
				var cursor  = interaction.MAIN.UI_CURSOR
				print("Object Origin: Container")
				selected_slot.quantity = cursor.quantity
				#for slot in interaction.HOTBAR.slots_hotbar.get_children():
					
				for slot in interaction.BACKPACK.base_grid.get_children():
					if slot is TextureRect: if slot.slot_held.visible == true:
						slot.slotted_object = null
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
				else: #Trade Hotbar object
					var trading_object = selected_slot.slotted_object
					var trading_texture = selected_slot.texture_object.texture
					var trading_quantity = selected_slot.quantity
					selected_slot.slotted_object = held_slot.slotted_object
					selected_slot.texture_object.texture =held_slot.texture_object.texture
					selected_slot.quantity = held_slot.quantity
					held_slot.slotted_object = trading_object
					held_slot.texture_object.texture = trading_texture
					held_slot.quantity = trading_quantity
					held_slot.slot_held.set_deferred("visible", false)
					interaction.revert()
			else: #Trade object from Ground
				print("Object Origin: Ground")
				var trading_object = interaction.current_object
				var trading_quantity = selected_slot.quantity
				var cursor = interaction.MAIN.UI_CURSOR
				interaction.interaction_objects.addto_hand(
					"All",
					selected_slot.slotted_object,
					null
				)
				cursor.cursor_fsm.object_switch = true
				selected_slot.quantity = cursor.quantity
				cursor.quantity = trading_quantity
				if cursor.quantity < 1: cursor.quantity = 1
				addto_hotbar(trading_object, selected_slot)
	print("#---Finished Trading---#")
#Check for Selection
func check_selection():
	for slot in interaction.HOTBAR.slots_hotbar.get_children():
		if slot.slot_selected.visible == true: return slot
#Check for Held object
func check_held(): 
	for slot in interaction.HOTBAR.slots_hotbar.get_children():
		if slot.slot_held.visible == true: return slot
