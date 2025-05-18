extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal send_colors
#Variables
#Exported Variables
@export_enum("Skin", "Hair", "Beard", "Eye1", "Eye2") var sprite_to_color: String
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
#Shader Parameters
@onready var new_outline1 = material.get("shader_parameter/new_outline1")
@onready var new_shadow1 = material.get("shader_parameter/new_shadow1")
@onready var new_base1 = material.get("shader_parameter/new_base1")
@onready var new_highlight1 = material.get("shader_parameter/new_highlight1")
@onready var new_outline2 = material.get("shader_parameter/new_outline2")
@onready var new_shadow2 = material.get("shader_parameter/new_shadow2")
@onready var new_base2 = material.get("shader_parameter/new_base2")
@onready var new_highlight2 = material.get("shader_parameter/new_highlight2")
@onready var new_outline3 = material.get("shader_parameter/new_outline3")
@onready var new_shadow3 = material.get("shader_parameter/new_shadow3")
@onready var new_base3 = material.get("shader_parameter/new_base3")
@onready var new_highlight3 = material.get("shader_parameter/highlight3")
#------------------------------------------------------------------------------#
#On Button Up
func _on_button_up() -> void:
	var color_id = str(name)
	var eyes_linked = UI_CUSTOMIZATION.checkbox_right.button_pressed
	var hair_linked = UI_CUSTOMIZATION.checkbox_top.button_pressed
	emit_signal("send_colors",
		color_id, sprite_to_color, eyes_linked, hair_linked, #Identifiers
		new_outline1, new_shadow1, new_base1, new_highlight1, #Color One
		new_outline2, new_shadow2, new_base2, new_highlight2, #Color Two
		new_outline3, new_shadow3, new_base3, new_highlight3, #Color Two
	)
