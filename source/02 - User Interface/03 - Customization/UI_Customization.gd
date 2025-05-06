extends HBoxContainer
#------------------------------------------------------------------------------#
#Signals
signal uic_height_change(scroll)
signal uic_chub_change(toggle)
signal uic_animation_change(scroll)
#------------------------------------------------------------------------------#
#Signaled Functions
#Height Buttons
func _on_previous_height_button_up() -> void:emit_signal("uic_height_change", "Previous")
func _on_next_height_button_up() -> void: emit_signal("uic_height_change", "Next")
#Chub Buttons
func _on_previous_chub_button_up() -> void: emit_signal("uic_chub_change")
func _on_next_chub_button_up() -> void: emit_signal("uic_chub_change")
#Animation Buttons
func _on_previous_animation_button_up() -> void: emit_signal("uic_animation_change", "Previous")
func _on_next_animation_button_up() -> void: emit_signal("uic_animation_change", "Next")
