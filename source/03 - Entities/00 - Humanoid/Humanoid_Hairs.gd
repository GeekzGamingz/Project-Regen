extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var hairs_short: Array[Resource] = []
@export var hairs_average: Array[Resource] = []
@export var hairs_tall: Array[Resource] = []
#OnReady Variables
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Custom Functions
func check_hair():
	match(e_customization.height_counter):
		0: texture = hairs_short[e_customization.hair_counter]
		1: texture = hairs_average[e_customization.hair_counter]
		2: texture = hairs_tall[e_customization.hair_counter]
