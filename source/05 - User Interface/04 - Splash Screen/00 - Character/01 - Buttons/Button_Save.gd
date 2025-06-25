extends Button
#------------------------------------------------------------------------------#
#Variables
#Dictionaries
var profiles = []
#OnReady Variables
#Local Nodes
@onready var line_profile: LineEdit = $"../../../LineEdit_Profile"
@onready var selection_character: HBoxContainer = $"../../Selection_Character"
@onready var sprites_dictionary: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary"
@onready var sprites_character: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character"
@onready var confirmation_container: VBoxContainer = $"../../../ConfirmationContainer"
@onready var line_confirmation: LineEdit = $"../../../ConfirmationContainer/LineEdit_Confirmation"
@onready var overwrite_container: HBoxContainer = $"../../../ConfirmationContainer/TabContainer/OverwriteContainer"
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: load_profiles(G.PATH_PROFILES)
#------------------------------------------------------------------------------#
#Input Functions
func _input(event: InputEvent) -> void:
	if event.is_action_released("action_context"): clear_line()
#------------------------------------------------------------------------------#
#Signaled Functions
#Save Button Up
func _on_button_up() -> void:
	line_profile.set_deferred("visible", true)
	line_profile.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#Profile Text Submitted
func _on_line_profile_text_submitted(new_text: String) -> void:
	var character_exists: bool = false
	for character in profiles:
		if character.get("profile") == new_text:
			line_confirmation.text = str(
				"Would you like to OVERWRITE Character: ",
				profiles[selection_character.character_counter].get("profile")
			)
			confirmation_container.set_deferred("visible", true)
			overwrite_container.set_deferred("visible", true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			line_profile.set_deferred("visible", false)
			character_exists = true
	if !character_exists: save_character(new_text)
#Confirm Button Up
func _on_button_confirm_button_up() -> void:
	save_character(line_profile.text)
	confirmation_container.set_deferred("visible", false)
#Decline Button Up
func _on_button_decline_button_up() -> void:
	confirmation_container.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Functions
func save_character(new_text: String):
	if new_text != "":
		sprites_dictionary.sprite_info.set("profile", new_text)
		for character in profiles:
			if character.get("profile") == new_text: profiles.erase(character)
		profiles.push_back(sprites_dictionary.sprite_info.duplicate())
		G.SAVE(G.PATH_PROFILES, profiles)
		selection_character.character_counter = profiles.size() - 1
		selection_character.check_character()
		clear_line()
#Clear Profile Line
func clear_line():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	line_profile.set_deferred("visible", false)
	line_profile.text = ""
#Load Profiles
func load_profiles(path): if FileAccess.file_exists(path): profiles = G.LOAD(path)
