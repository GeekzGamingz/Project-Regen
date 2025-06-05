extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var hair_counter: int = 0
#Arrays
@export var hairs: Array[Resource] = []
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
func _ready() -> void: ui_customization.connect("uic_hair_change", uic_hair_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_hair_change(scroll):
	match(scroll):
		"Previous": hair_counter -= 1
		"Next": hair_counter += 1
	if hair_counter == hairs.size(): hair_counter = 0
	elif hair_counter < 0: hair_counter = hairs.size() -1
	sprites_dictionary.sprite_info["hair"] = hair_counter
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
func check_hair():
	if selection_character.is_new:
		texture = hairs[hair_counter]
		match(sprite_base.height_counter):
			0: offset.y = 2.0
			1: offset.y = 0
			2: offset.y = -2.0
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles
		texture = hairs[profiles[counter].get("hair")]
		match(int(profiles[counter].get("height"))):
			0: offset.y = 2.0
			1: offset.y = 0
			2: offset.y = -2.0
	sprites_dictionary.sprite_paths.set("sprite_hair", texture.resource_path)
