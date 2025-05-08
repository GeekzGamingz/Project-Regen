extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var beards_short: Array[Resource] = []
@export var beards_average: Array[Resource] = []
@export var beards_tall: Array[Resource] = []
#OnReady Variables
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Custom Functions
func check_beard():
	match(e_customization.height_counter):
		0: texture = beards_short[e_customization.beard_counter]
		1: texture = beards_average[e_customization.beard_counter]
		2: texture = beards_tall[e_customization.beard_counter]
