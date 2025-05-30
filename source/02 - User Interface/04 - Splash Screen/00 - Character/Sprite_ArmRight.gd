extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var arm_right_counter: int = 1
#Arrays
@export_category("Average")
@export var arms_right_short_average: Array[Resource] = []
@export var arms_right_average_average: Array[Resource] = []
@export var arms_right_tall_average: Array[Resource] = []
@export_category("Chub")
@export var arms_right_short_chub: Array[Resource] = []
@export var arms_right_average_chub: Array[Resource] = []
@export var arms_right_tall_chub: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var selection_character: HBoxContainer = $"../../../../.."
@onready var splash_screen: Control = $"../../../../../../../../../.."
@onready var sprite_base: Sprite2D = sprites_character.get_node("Sprites_Body/Sprite_Base")
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_arm_right_change", uic_arm_right_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Arm Right
func uic_arm_right_change(scroll):
	match(scroll):
		"Previous": arm_right_counter -= 1
		"Next": arm_right_counter += 1
	if arm_right_counter == arms_right_average_average.size(): arm_right_counter = 0
	elif arm_right_counter < 0: arm_right_counter = arms_right_average_average.size() - 1
	sprites_character.sprite_info["arm_right"] = arm_right_counter
#------------------------------------------------------------------------------#
#Custom Functions
func check_arm_right():
	if selection_character.is_new:
		match(sprites_character.is_chub):
			false: match(sprite_base.height_counter):
				0: texture = arms_right_short_average[arm_right_counter]
				1: texture = arms_right_average_average[arm_right_counter]
				2: texture = arms_right_tall_average[arm_right_counter]
			true: match(sprite_base.height_counter):
				0: texture = arms_right_short_chub[arm_right_counter]
				1: texture = arms_right_average_chub[arm_right_counter]
				2: texture = arms_right_tall_chub[arm_right_counter]
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles
		match(profiles[counter].get("chub")):
			false: match(int(profiles[counter].get("height"))):
				0: texture = arms_right_short_average[profiles[counter].get("arm_right")]
				1: texture = arms_right_average_average[profiles[counter].get("arm_right")]
				2: texture = arms_right_tall_average[profiles[counter].get("arm_right")]
			true: match(int(profiles[counter].get("height"))):
				0: texture = arms_right_short_chub[profiles[counter].get("arm_right")]
				1: texture = arms_right_average_chub[profiles[counter].get("arm_right")]
				2: texture = arms_right_tall_chub[profiles[counter].get("arm_right")]
