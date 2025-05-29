extends HBoxContainer
#------------------------------------------------------------------------------#
#Variables
#Integers
var character_counter: int = 0
#OnReady Variables
#Local Nodes
@onready var previous_character: TextureButton = $Previous_Character
@onready var next_character: TextureButton = $Next_Character
@onready var button_save: Button = $"../SaveContainer/Button_Save"
@onready var label_character: Label = $"../Label_Character"
@onready var sprites_character: Node2D = $SubviewportContainer/SubViewport/Sprites_Character
@onready var sprites_colors: Node2D = $SubviewportContainer/SubViewport/Sprites_Character/Sprites_Colors
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	await get_tree().process_frame
	check_character()
#------------------------------------------------------------------------------#
#Signaled Functions
#Character Buttons Up
func _on_previous_character_button_up() -> void:
	character_counter -= 1
	check_character()
func _on_next_character_button_up() -> void:
	character_counter += 1
	check_character()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Character
func check_character():
	if FileAccess.file_exists(G.PATH_PROFILES):
		if character_counter < 0: character_counter = button_save.profiles.size() - 1
		elif character_counter >= button_save.profiles.size(): character_counter = 0
		print(sprites_character.sprite_info)
		label_character.text = str("[", button_save.profiles[character_counter].get("profile"), "]")
		sprites_character.sprite_info = button_save.profiles[character_counter].duplicate()
		print(sprites_character.sprite_info)
		sprites_colors.check_colors()
