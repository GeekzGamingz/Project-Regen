extends Button
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Local Nodes
@onready var save_container: HBoxContainer = $".."
@onready var button_save: Button = $"../Button_Save"
@onready var selection_character: HBoxContainer = $"../../Selection_Character"
@onready var sprites_dictionary: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary"
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void:
	if button_save.profiles.size() == 1: set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Signaled Functions
#On Delete Up
func _on_button_up() -> void:
	if button_save.profiles.size() != 1:
		sprites_dictionary.update_dictionary("Delete")
		selection_character._on_next_character_button_up()
		G.SAVE(G.PATH_PROFILES, button_save.profiles)
