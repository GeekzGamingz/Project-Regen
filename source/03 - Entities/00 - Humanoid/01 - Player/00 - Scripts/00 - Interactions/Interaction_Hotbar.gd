extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Check Duplicate Item
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
#Add to Hotbar
func addto_hotbar(object, hotbar_selected):
	hotbar_selected.is_empty = false
	hotbar_selected.texture_object.texture = object.sprite_hotbar.texture
	var object_scene = object.duplicate()
	hotbar_selected.slotted_item = object_scene
#Trade Slots
func trade_slots(contents):
	match(contents):
		"Empty":
			print("#---Trading Executed - Slot Empty---#")
			print("Held Object: ", interaction.current_object.name)
			print("Object Origin: ", check_held().name)
			print("Slot Destination: ", check_selection().name)
			addto_hotbar(interaction.current_object, check_selection())
			check_selection().quantity = check_held().quantity
			check_held().is_empty = true
			interaction.revert()
		"Full":
			print("#---Trading Executed - Slot Occupied---#")
			print("Held Object: ", interaction.current_object.name)
			print("Slot Destination: ", check_selection().name)
			print("Object Replacing: ", check_selection().slotted_item.name)
			if check_held() != null:
				print("Slot Origin: ", check_held().name)
				if check_held() == check_selection():
					interaction.interaction_objects.cancel(
						interaction.current_object,
						check_held()
					) #Cancel if Selections Match
				else: #Trade Hotbar Item
					var trading_object = check_selection().slotted_item
					var trading_texture = check_selection().texture_object.texture
					var trading_quantity = check_selection().quantity
					check_selection().slotted_item = check_held().slotted_item
					check_selection().texture_object.texture = check_held().texture_object.texture
					check_selection().quantity = check_held().quantity
					check_held().slotted_item = trading_object
					check_held().texture_object.texture = trading_texture
					check_held().quantity = trading_quantity
					check_held().slot_held.set_deferred("visible", false)
					interaction.revert()
			else: #Trade Item from Ground
				print("Object Origin: Ground")
				var trading_object = interaction.current_object
				var trading_quantity = check_selection().quantity
				interaction.interaction_objects.addto_hand(
					check_selection().slotted_item,
					null
				)
				interaction.MAIN.UI_CURSOR.cursor_fsm.object_switch = true
				#interaction.MAIN.UI_CURSOR.output_quantity.set_deferred("visible", true)
				check_selection().quantity = interaction.MAIN.UI_CURSOR.quantity
				interaction.MAIN.UI_CURSOR.quantity = trading_quantity
				if interaction.MAIN.UI_CURSOR.quantity < 1: interaction.MAIN.UI_CURSOR.quantity = 1
				interaction.MAIN.UI_CURSOR.output_quantity.text = str(trading_quantity)
				addto_hotbar(trading_object, check_selection())
	print("#---Finished Trading---#")
#Check for Selection
func check_selection():
	for slot in interaction.HOTBAR.get_node("SlotContainer_Hotbar").get_children():
		if slot.slot_selected.visible == true: return slot
#Check for Held Item
func check_held(): 
	for slot in interaction.HOTBAR.get_node("SlotContainer_Hotbar").get_children():
		if slot.slot_held.visible == true: return slot
