extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal send_colors
#Variables
#Exported Variables
@export_enum("Skin", "Hair", "Beard", "Eye1", "Eye2") var sprite_to_color: String
#OnReady Variables
@onready var new_outline = material.get("shader_parameter/new_outline1")
@onready var new_shadow = material.get("shader_parameter/new_shadow1")
@onready var new_base = material.get("shader_parameter/new_base1")
@onready var new_highlight = material.get("shader_parameter/new_highlight1")
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
func _on_button_up() -> void: emit_signal("send_colors",
	sprite_to_color, # Sprite to Color
	new_outline, new_shadow, new_base, new_highlight, # Color One
	new_outline2, new_shadow2, new_base2, new_highlight2, # Color Two
	new_outline3, new_shadow3, new_base3, new_highlight3, # Color Two
	)
