extends TabContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var skin: GridContainer = $Skin/Grid_Skin
@onready var hair: GridContainer = $Hair/Top/Grid_Top
@onready var beard: GridContainer = $Hair/Facial/Grid_Facial
@onready var eye_left: GridContainer = $Eyes/Left/Grid_Left
@onready var eye_right: GridContainer = $Eyes/Right/Grid_Right
#------------------------------------------------------------------------------#
#Custom Functions
#Random Color
func random_color(colorable):
	randomize()
	var button_parent
	var button_array: Array = []
	match(colorable):
		"Skin": button_parent = skin
		"Hair": button_parent = hair
		"Beard": button_parent = beard
		"EyeL": button_parent = eye_left
		"EyeR": button_parent = eye_right
	for button in button_parent.get_children(): button_array.append(button)
	button_array.pick_random().emit_signal("button_up")
