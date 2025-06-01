extends Button
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Local Nodes
@onready var save_container: HBoxContainer = $".."
@onready var button_save: Button = $"../Button_Save"
@onready var selection_character: HBoxContainer = $"../../Selection_Character"
@onready var sprites_dictionary: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary"
@onready var confirmation_container: VBoxContainer = $"../../../ConfirmationContainer"
@onready var line_confirmation: LineEdit = $"../../../ConfirmationContainer/LineEdit_Confirmation"
@onready var delete_container: HBoxContainer = $"../../../ConfirmationContainer/TabContainer/DeleteContainer"
@onready var button_confirm: Button = $"../../../ConfirmationContainer/TabContainer/DeleteContainer/Button_Confirm"
@onready var button_decline: Button = $"../../../ConfirmationContainer/TabContainer/DeleteContainer/Button_Decline"
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void:
	if button_save.profiles.size() == 1: set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Signaled Functions
#On Delete Up
func _on_button_up() -> void:
	line_confirmation.text = str(
		"Would you like to DELETE Character: ",
		button_save.profiles[selection_character.character_counter].get("profile")
	)
	confirmation_container.set_deferred("visible", true)
	delete_container.set_deferred("visible", true)
#On Confirm Up
func _on_button_confirm_button_up() -> void:
	if button_save.profiles.size() != 1:
		sprites_dictionary.update_dictionary("Delete")
		selection_character._on_next_character_button_up()
		G.SAVE(G.PATH_PROFILES, button_save.profiles)
		confirmation_container.set_deferred("visible", false)
#On Decline Up
func _on_button_decline_button_up() -> void:
	confirmation_container.set_deferred("visible", false)
