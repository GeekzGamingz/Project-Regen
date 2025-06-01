extends HBoxContainer
#------------------------------------------------------------------------------#
#Variables
#Integers
var character_counter: int = 0
#Bools
var is_new: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
#Local Nodes
@onready var previous_character: TextureButton = $Previous_Character
@onready var next_character: TextureButton = $Next_Character
@onready var label_character: Label = $"../Label_Character"
@onready var save_container: HBoxContainer = $"../SaveContainer"
@onready var button_save: Button = $"../SaveContainer/Button_Save"
@onready var sprites_dictionary: Node2D = $SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary
@onready var sprites_colors: Node2D = $SubviewportContainer/SubViewport/Sprites_Character/Sprites_Colors
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void:
	if button_save.profiles.size() == 1:
		previous_character.set_deferred("visible", false)
		next_character.set_deferred("visible", false)
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
		loaded_buttons(true)
		UI_CUSTOMIZATION.set_deferred("visible", false)
		if character_counter < 0: character_counter = save_container.button_save.profiles.size() - 1
		elif character_counter >= save_container.button_save.profiles.size(): character_counter = 0
		label_character.text = str("✰ ", save_container.button_save.profiles[character_counter].get("profile"), " ✰")
		sprites_dictionary.sprite_info = save_container.button_save.profiles[character_counter].duplicate()
		sprites_colors.check_colors()
	else:
		loaded_buttons(false)
#Button Visibility
func loaded_buttons(visibility: bool):
	is_new = !visibility
	save_container.button_new.set_deferred("visible", visibility)
	save_container.button_edit.set_deferred("visible", visibility)
	save_container.button_delete.set_deferred("visible", visibility)
	save_container.button_save.set_deferred("visible", !visibility)
	previous_character.set_deferred("visible", visibility)
	next_character.set_deferred("visible", visibility)
	
