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
	if interaction.full_hotbar: print("FULL HOTBAR")
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
		"Empty": print("Trading Executed - Slot Empty")
		"Full": print("Trading Executed - Slot Occupied")
