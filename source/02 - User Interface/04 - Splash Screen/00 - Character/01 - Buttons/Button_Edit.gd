extends Button
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Local Nodes
@onready var save_container: HBoxContainer = $".."
@onready var sprites_dictionary: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary"
#------------------------------------------------------------------------------#
#Signaled Functions
#On Button Up
func _on_button_up() -> void:
	button_visibility(true)
	sprites_dictionary.update_dictionary("Edit")
#------------------------------------------------------------------------------#
#Custom Functions
#Button Visibility
func button_visibility(visibility: bool):
	save_container.button_save.set_deferred("visible", visibility)
	save_container.button_delete.set_deferred("visible", visibility)
	save_container.button_new.set_deferred("visible", !visibility)
	save_container.selection_character.UI_CUSTOMIZATION.set_deferred("visible", visibility)
