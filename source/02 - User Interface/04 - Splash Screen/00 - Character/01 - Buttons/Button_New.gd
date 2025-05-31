extends Button
@onready var save_container: HBoxContainer = $".."

@onready var label_character: Label = $"../../Label_Character"

@onready var sprites_character: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character"

@onready var sprites_dictionary: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Dictionary"
@onready var sprites_colors: Node2D = $"../../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Colors"

func _on_button_up() -> void:
	button_visibility(true)
	sprites_dictionary.update_dictionary("New")
	sprites_character.check_sprites("")
	sprites_colors.check_colors()
	label_character.text = "[New Character]"
	
#Button Visibility
func button_visibility(visibility: bool):
	save_container.button_save.set_deferred("visible", visibility)
	save_container.button_edit.set_deferred("visible", !visibility)
	save_container.button_delete.set_deferred("visible", !visibility)
	save_container.button_new.set_deferred("visible", !visibility)
	save_container.selection_character.UI_CUSTOMIZATION.set_deferred("visible", visibility)
