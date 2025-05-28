extends Button
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Local Nodes
@onready var line_profile: LineEdit = $"../../../LineEdit_Profile"
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
	clear_line()
	save_profile()
#------------------------------------------------------------------------------#
#Custom Functions
#Clear Profile Line
func clear_line():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	line_profile.set_deferred("visible", false)
	line_profile.text = ""
#Save Profile
func save_profile(): pass
