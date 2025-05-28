extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var leg_right_counter: int = 1
#Arrays
@export_category("Average")
@export var legs_right_short_average: Array[Resource] = []
@export var legs_right_average_average: Array[Resource] = []
@export var legs_right_tall_average: Array[Resource] = []
@export_category("Chub")
@export var legs_right_short_chub: Array[Resource] = []
@export var legs_right_average_chub: Array[Resource] = []
@export var legs_right_tall_chub: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var splash_screen: Control = $"../../../../../../../../.."
@onready var sprite_base: Sprite2D = sprites_character.get_node("Sprites_Body/Sprite_Base")
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_leg_right_change", uic_leg_right_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Arm Right
func uic_leg_right_change(scroll):
	match(scroll):
		"Previous": leg_right_counter -= 1
		"Next": leg_right_counter += 1
	if leg_right_counter == legs_right_average_average.size(): leg_right_counter = 0
	elif leg_right_counter < 0: leg_right_counter = legs_right_average_average.size() - 1
#------------------------------------------------------------------------------#
#Custom Functions
func check_leg_right():
	match(sprites_character.is_chub):
		false: match(sprite_base.height_counter):
			0: texture = legs_right_short_average[leg_right_counter]
			1: texture = legs_right_average_average[leg_right_counter]
			2: texture = legs_right_tall_average[leg_right_counter]
		true: match(sprite_base.height_counter):
			0: texture = legs_right_short_chub[leg_right_counter]
			1: texture = legs_right_average_chub[leg_right_counter]
			2: texture = legs_right_tall_chub[leg_right_counter]
