extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var ears_short: Array[Resource] = []
@export var ears_average: Array[Resource] = []
@export var ears_tall: Array[Resource] = []
#OnReady Variables
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Custom Functions
func check_ears():
	match(e_customization.height_counter):
		0: texture = ears_short[e_customization.ear_counter]
		1: texture = ears_average[e_customization.ear_counter]
		2: texture = ears_tall[e_customization.ear_counter]
