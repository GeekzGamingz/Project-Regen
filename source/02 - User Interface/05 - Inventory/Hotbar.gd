extends Control

var hotbar_array: Array = []
var hotbar_selection: int

@onready var slots_hotbar: HBoxContainer = $SlotContainer_Hotbar

func _ready() -> void:
	generate_hotbar()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_next"): scroll_hotbar("Next")
	if event.is_action_pressed("hotbar_previous"): scroll_hotbar("Previous")

func generate_hotbar():
	for slot in slots_hotbar.get_children():
		hotbar_array.append(slot)
	print(hotbar_array)

func scroll_hotbar(scroll):
	check_hotbar()
	match(scroll):
		"Next": 
			hotbar_selection += 1
		"Previous":
			hotbar_selection -= 1
	check_hotbar()
	for slot in hotbar_array: slot.get_node("NPR_Selection").hide()
	hotbar_array[hotbar_selection].get_node("NPR_Selection").show()
	print(hotbar_array[hotbar_selection])

func check_hotbar():
	if hotbar_selection == hotbar_array.size(): hotbar_selection = 0
	elif hotbar_selection < 0: hotbar_selection = hotbar_array.size() - 1
