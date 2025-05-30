extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var ear_counter: int = 0
#Arrays
@export var ears: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var selection_character: HBoxContainer = $"../../../../.."
@onready var splash_screen: Control = $"../../../../../../../../../.."
@onready var sprite_base: Sprite2D = sprites_character.get_node("Sprites_Body/Sprite_Base")
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_ear_change", uic_ear_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_ear_change(scroll):
	match(scroll):
		"Previous": ear_counter -= 1
		"Next": ear_counter += 1
	if ear_counter == ears.size(): ear_counter = 0
	elif ear_counter < 0: ear_counter = ears.size() -1
	sprites_character.sprite_info["ears"] = ear_counter
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
func check_ears():
	if selection_character.is_new:
		texture = ears[ear_counter]
		match(sprite_base.height_counter):
			0: offset.y = 2.0
			1: offset.y = 0
			2: offset.y = -2.0
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles
		texture = ears[profiles[counter].get("ears")]
		match(int(profiles[counter].get("height"))):
			0: offset.y = 2.0
			1: offset.y = 0
			2: offset.y = -2.0
