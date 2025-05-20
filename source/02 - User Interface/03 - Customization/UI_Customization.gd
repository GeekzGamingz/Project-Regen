extends HBoxContainer
#------------------------------------------------------------------------------#
#Signals
signal uic_hair_change(scroll)
signal uic_ear_change(scroll)
signal uic_beard_change(scroll)
signal uic_height_change(scroll)
signal uic_arm_left_change(scroll)
signal uic_arm_right_change(scroll)
signal uic_chub_change(toggle)
signal uic_animation_change(scroll)
#------------------------------------------------------------------------------#
#OnReady Variables
#Buttons
@onready var skin: VBoxContainer = $VBoxContainer/Selection_Color/Skin
@onready var hair: TabContainer = $VBoxContainer/Selection_Color/Hair
@onready var top: VBoxContainer = $VBoxContainer/Selection_Color/Hair/Top
@onready var facial: VBoxContainer = $VBoxContainer/Selection_Color/Hair/Facial
#Linked Checkboxes
@onready var checkbox_left: CheckBox = $VBoxContainer/Selection_Color/Eyes/Left/HBoxContainer/CheckBox_Left
@onready var checkbox_right: CheckBox = $VBoxContainer/Selection_Color/Eyes/Right/HBoxContainer/CheckBox_Right
@onready var checkbox_top: CheckBox = $VBoxContainer/Selection_Color/Hair/Top/HBoxContainer/CheckBox_Top
@onready var checkbox_facial: CheckBox = $VBoxContainer/Selection_Color/Hair/Facial/HBoxContainer/CheckBox_Facial
#------------------------------------------------------------------------------#
#Signaled Functions
#Height Buttons
func _on_previous_height_button_up() -> void:
	emit_signal("uic_height_change", "Previous")
	skin.set_deferred("visible", true)
func _on_next_height_button_up() -> void:
	emit_signal("uic_height_change", "Next")
	skin.set_deferred("visible", true)
#Ear Buttons
func _on_previous_ears_button_up() -> void:
	emit_signal("uic_ear_change", "Previous")
	skin.set_deferred("visible", true)
func _on_next_ears_button_up() -> void:
	emit_signal("uic_ear_change", "Next")
	skin.set_deferred("visible", true)
#Hair Buttons
func _on_previous_hair_button_up() -> void:
	emit_signal("uic_hair_change", "Previous")
	hair.set_deferred("visible", true)
	top.set_deferred("visible", true)
func _on_next_hair_button_up() -> void:
	emit_signal("uic_hair_change", "Next")
	hair.set_deferred("visible", true)
	top.set_deferred("visible", true)
#Beard Buttons
func _on_previous_beard_button_up() -> void:
	emit_signal("uic_beard_change", "Previous")
	hair.set_deferred("visible", true)
	facial.set_deferred("visible", true)
func _on_next_beard_button_up() -> void:
	emit_signal("uic_beard_change", "Next")
	hair.set_deferred("visible", true)
	facial.set_deferred("visible", true)
#Arms
#Left Arm
func _on_previous_arm_l_button_up() -> void:
	emit_signal("uic_arm_left_change", "Previous")
	skin.set_deferred("visible", true)
func _on_next_arm_l_button_up() -> void:
	emit_signal("uic_arm_left_change", "Next")
	skin.set_deferred("visible", true)
#Right Arm
func _on_previous_arm_r_button_up() -> void:
	emit_signal("uic_arm_right_change", "Previous")
	skin.set_deferred("visible", true)
func _on_next_arm_r_button_up() -> void:
	emit_signal("uic_arm_right_change", "Next")
	skin.set_deferred("visible", true)
#Legs
#Left Leg

#Right Leg

#ChubBox
func _on_check_box_chub_toggled(toggled_on: bool) -> void: emit_signal("uic_chub_change", toggled_on)
#Link Hair Colors
func _on_check_box_top_toggled(toggled_on: bool) -> void: checkbox_facial.button_pressed = toggled_on
func _on_check_box_facial_toggled(toggled_on: bool) -> void: checkbox_top.button_pressed = toggled_on
#Link Eye Colors
func _on_check_box_left_toggled(toggled_on: bool) -> void: checkbox_right.button_pressed = toggled_on
func _on_check_box_right_toggled(toggled_on: bool) -> void: checkbox_left.button_pressed = toggled_on
#Animation Buttons
func _on_previous_animation_button_up() -> void: emit_signal("uic_animation_change", "Previous")
func _on_next_animation_button_up() -> void: emit_signal("uic_animation_change", "Next")
