extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var arm_left_counter: int = 1
#Arrays
@export_category("Average")
@export var arms_left_short_average: Array[Resource] = []
@export var arms_left_average_average: Array[Resource] = []
@export var arms_left_tall_average: Array[Resource] = []
@export_category("Chub")
@export var arms_left_short_chub: Array[Resource] = []
@export var arms_left_average_chub: Array[Resource] = []
@export var arms_left_tall_chub: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var selection_character: HBoxContainer = $"../../../../.."
@onready var sprites_dictionary: Node2D = $"../../Sprites_Dictionary"
@onready var splash_screen: Control = $"../../../../../../../../../.."
@onready var sprite_base: Sprite2D = sprites_character.get_node("Sprites_Body/Sprite_Base")
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_arm_left_change", uic_arm_left_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Arm left
func uic_arm_left_change(scroll):
	match(scroll):
		"Previous": arm_left_counter -= 1
		"Next": arm_left_counter += 1
	if arm_left_counter == arms_left_average_average.size(): arm_left_counter = 0
	elif arm_left_counter < 0: arm_left_counter = arms_left_average_average.size() - 1
	sprites_dictionary.sprite_info["arm_left"] = arm_left_counter
#------------------------------------------------------------------------------#
#Custom Functions
func check_arm_left():
	if selection_character.is_new:
		match(sprites_character.is_chub):
			false: match(sprite_base.height_counter):
				0: texture = arms_left_short_average[arm_left_counter]
				1: texture = arms_left_average_average[arm_left_counter]
				2: texture = arms_left_tall_average[arm_left_counter]
			true: match(sprite_base.height_counter):
				0: texture = arms_left_short_chub[arm_left_counter]
				1: texture = arms_left_average_chub[arm_left_counter]
				2: texture = arms_left_tall_chub[arm_left_counter]
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles
		match(profiles[counter].get("chub")):
			false: match(int(profiles[counter].get("height"))):
				0: texture = arms_left_short_average[profiles[counter].get("arm_left")]
				1: texture = arms_left_average_average[profiles[counter].get("arm_left")]
				2: texture = arms_left_tall_average[profiles[counter].get("arm_left")]
			true: match(int(profiles[counter].get("height"))):
				0: texture = arms_left_short_chub[profiles[counter].get("arm_left")]
				1: texture = arms_left_average_chub[profiles[counter].get("arm_left")]
				2: texture = arms_left_tall_chub[profiles[counter].get("arm_left")]
