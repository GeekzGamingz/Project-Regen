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
	if event.is_action_pressed("hotbar_next"): scroll_hotbar("Next")
	if event.is_action_pressed("hotbar_previous"): scroll_hotbar("Previous")
#------------------------------------------------------------------------------#
#Custom Functions
#Generate Hotbar
func generate_hotbar():
	for slot in slots_hotbar.get_children(): hotbar_array.append(slot)
#Scroll Hotbar Slot
func scroll_hotbar(scroll):
	match(scroll):
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
