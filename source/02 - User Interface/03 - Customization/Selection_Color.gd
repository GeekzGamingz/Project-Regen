extends TabContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var skin: GridContainer = $Skin
@onready var eye_left: GridContainer = $Eyes/Left/Grid_Left
@onready var eye_right: GridContainer = $Eyes/Right/Grid_Right
#------------------------------------------------------------------------------#
func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	random_color("Skin")
	random_color("EyeL")
	random_color("EyeR")
#Custom Functions
#Random Color
func random_color(colorable):
	randomize()
	var button_parent
	var button_array: Array = []
	match(colorable):
		"Skin": button_parent = skin
		"EyeL": button_parent = eye_left
		"EyeR": button_parent = eye_right
	for button in button_parent.get_children(): button_array.append(button)
	button_array.pick_random().emit_signal("button_up")
