extends Control
#------------------------------------------------------------------------------#
#Variables
#Integers
var hotbar_selection: int
#Arrays
var hotbar_array: Array = []
#OnReady Variables
@onready var slots_hotbar: HBoxContainer = $SlotContainer_Hotbar
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: generate_hotbar()
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_next"):
		if !event.is_action_pressed("zoom_out"): scroll_hotbar("Next")
	if event.is_action_pressed("hotbar_previous"): 
		if !event.is_action_pressed("zoom_in"): scroll_hotbar("Previous")
#------------------------------------------------------------------------------#
#Custom Functions
#Generate Hotbar
func generate_hotbar():
	for slot in slots_hotbar.get_children(): hotbar_array.append(slot)
#Scroll Hotbar Slot
func scroll_hotbar(scroll):
	match(scroll):
		"HotbarSlot1": hotbar_selection = 0
		"HotbarSlot2": hotbar_selection = 1
		"HotbarSlot3": hotbar_selection = 2
		"HotbarSlot4": hotbar_selection = 3
		"HotbarSlot5": hotbar_selection = 4
		"HotbarSlot6": hotbar_selection = 5
		"HotbarSlot7": hotbar_selection = 6
		"HotbarSlot8": hotbar_selection = 7
		"HotbarSlot9": hotbar_selection = 8
		"HotbarSlot10": hotbar_selection = 9
		"HotbarSlot11": hotbar_selection = 10
		"HotbarSlot12": hotbar_selection = 11
		"Next": hotbar_selection += 1
		"Previous": hotbar_selection -= 1
	check_hotbar()
	for slot in hotbar_array: slot.get_node("NPR_Selection").hide()
	var selection = hotbar_array[hotbar_selection]
	selection.get_node("NPR_Selection").show()
	print(selection.name, ": ", selection.contents)
#Check Hotbar Selection
func check_hotbar():
	if hotbar_selection == hotbar_array.size(): hotbar_selection = 0
	elif hotbar_selection < 0: hotbar_selection = hotbar_array.size() - 1
