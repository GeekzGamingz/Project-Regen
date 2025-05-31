extends Node2D
@onready var sprites_character: Node2D = $".."
@onready var selection_character: HBoxContainer = $"../../../.."
#Dictionaries
var archived_sprite_info: Dictionary = {}
var old_sprite_info: Dictionary = {}
@export var sprite_info: Dictionary = {
	"profile": String(""),
	"height": int(1),
	"chub": bool(false),
	"wheelchair": bool(false),
	"arm_left": int(1),
	"arm_right": int(1),
	"leg_left": int(1), 
	"leg_right": int(1), 
	"ears": int(0),
	"eyeL_color": String("Button_Color1"),
	"eyeR_color": String("Button_Color1"),
	"skin_color": String("Button_Color1"),
	"hair": int(0),
	"hair_color": String("Button_Color1"),
	"bangs": int(0),
	"beard": int(0),
	"beard_color": String("Button_Color1")
}
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: archived_sprite_info = sprite_info
#------------------------------------------------------------------------------#
#Custom Functions
#Update Dictionary
func update_dictionary(mode):
	var counter = selection_character.character_counter
	var profiles = selection_character.save_container.button_save.profiles
	selection_character.is_new = true
	match(mode):
		"New":
			#Counters
			sprites_character.sprite_base.height_counter = int(1)
			sprites_character.is_chub = false
			sprites_character.is_wheels = false
			sprites_character.sprite_arm_right.arm_right_counter = int(1)
			sprites_character.sprite_arm_left.arm_left_counter = int(1)
			sprites_character.sprite_leg_right.leg_right_counter = int(1)
			sprites_character.sprite_leg_left.leg_left_counter = int(1)
			sprites_character.sprite_ears.ear_counter = int(0)
			sprites_character.sprite_hair.hair_counter = int(0)
			sprites_character.sprite_beard.beard_counter = int(0)
			#Sprite Info
			sprite_info = archived_sprite_info
		"Edit":
			sprites_character.sprite_base.height_counter = int(profiles[counter].get("height"))
			sprites_character.is_chub = profiles[counter].get("chub")
			sprites_character.is_wheels = profiles[counter].get("wheelchair")
			sprites_character.sprite_arm_right.arm_right_counter = int(profiles[counter].get("arm_right"))
			sprites_character.sprite_arm_left.arm_left_counter = int(profiles[counter].get("arm_left"))
			sprites_character.sprite_leg_right.leg_right_counter = int(profiles[counter].get("leg_right"))
			sprites_character.sprite_leg_left.leg_left_counter = int(profiles[counter].get("leg_left"))
			sprites_character.sprite_ears.ear_counter = int(profiles[counter].get("ears"))
			sprites_character.sprite_hair.hair_counter = int(profiles[counter].get("hair"))
			sprites_character.sprite_beard.beard_counter = int(profiles[counter].get("beard"))
			
