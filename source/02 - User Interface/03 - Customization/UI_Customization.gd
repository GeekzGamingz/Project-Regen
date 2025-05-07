extends HBoxContainer
#------------------------------------------------------------------------------#
#Signals
signal uic_height_change(scroll)
signal uic_chub_change(toggle)
signal uic_animation_change(scroll)
#------------------------------------------------------------------------------#
#OnReady Variables
@onready var checkbox_left: CheckBox = $VBoxContainer/TabContainer/Eyes/Left/HBoxContainer/CheckBox_Left
@onready var checkbox_right: CheckBox = $VBoxContainer/TabContainer/Eyes/Right/HBoxContainer/CheckBox_Right
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
#Link Eye Colors
func _on_check_box_left_toggled(toggled_on: bool) -> void: checkbox_right.button_pressed = toggled_on
func _on_check_box_right_toggled(toggled_on: bool) -> void: checkbox_left.button_pressed = toggled_on
