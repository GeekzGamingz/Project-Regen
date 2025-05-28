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
@onready var splash_screen: Control = $"../../../../../../../../.."
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
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
func check_hair():
	texture = hairs[hair_counter]
	match(sprite_base.height_counter):
		0: offset.y = 2.0
		1: offset.y = 0
		2: offset.y = -2.0
