extends Node2D
#------------------------------------------------------------------------------#
#Constants
const BASE_SHORT_AVERAGE = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_short_average.png")
const BASE_SHORT_CHUB = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_short_chub.png")
const BASE_AVERAGE_AVERAGE = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_average_average.png")
const BASE_AVERAGE_CHUB = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_average_chub.png")
const BASE_TALL_AVERAGE = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_tall_average.png")
const BASE_TALL_CHUB = preload("res://assets/03 - Entities/00 - Player/00 - Base/base_tall_chub.png")
#------------------------------------------------------------------------------#
#Variables
#Integers
var anim_counter: int = 1
var height_counter: int = 1
#Bools
var is_chub: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
#Entity Nodes
@onready var e: Entity = get_parent().get_parent()
@onready var sprite_base: Sprite2D = $"../../Sprites/Sprite_Base"
#Ready Function
func _ready() -> void:
	UI_CUSTOMIZATION.connect("visibility_changed", anim_tree_toggle)
	UI_CUSTOMIZATION.connect("uic_height_change", uic_height_change)
	UI_CUSTOMIZATION.connect("uic_chub_change", uic_chub_change)
	UI_CUSTOMIZATION.connect("uic_animation_change", uic_animation_change)
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/TabContainer/Skin").get_children():
		button.connect("send_colors", send_colors)
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	if is_chub == false:
		match(height_counter):
			0: e.sprite_base.texture = BASE_SHORT_AVERAGE
			1: e.sprite_base.texture = BASE_AVERAGE_AVERAGE
			2: e.sprite_base.texture = BASE_TALL_AVERAGE
	if is_chub == true:
		match(height_counter):
			0: e.sprite_base.texture = BASE_SHORT_CHUB
			1: e.sprite_base.texture = BASE_AVERAGE_CHUB
			2: e.sprite_base.texture = BASE_TALL_CHUB
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_height_change(scroll):
	match(scroll):
		"Previous": height_counter -= 1
		"Next": height_counter += 1
	if height_counter == 3: height_counter = 0
	elif height_counter == -1: height_counter = 2
	check_base()
#Change Chub
func uic_chub_change():
	is_chub = !is_chub
	check_base()
#Change Animation
func uic_animation_change(scroll):
	var animation_list = e.sprite_player.get_animation_list()
	e.anim_tree.active = false
	match(scroll):
		"Previous": anim_counter -= 1
		"Next": anim_counter += 1
	if anim_counter == 0: anim_counter = animation_list.size() - 1
	elif anim_counter == animation_list.size(): anim_counter = 1
	var anim_desired = (animation_list.get(anim_counter))
	e.sprite_player.play(anim_desired)
#Animation Tree Toggle
func anim_tree_toggle(): e.anim_tree.active = !e.anim_tree.active
#Change Colors
func send_colors(
	sprite_to_color, # Sprite to Color
	new_outline1, new_shadow1, new_base1, new_highlight1, # Color One
	_new_outline2, _new_shadow2, _new_base2, _new_highlight2, # Color Two
	_new_outline3, _new_shadow3, _new_base3, _new_highlight3, # Color Two
	):
	var sprite = Sprite2D
	match(sprite_to_color):
		"Skin": sprite = sprite_base
	sprite.material.set("shader_parameter/new_outline1", new_outline1)
	sprite.material.set("shader_parameter/new_shadow1", new_shadow1)
	sprite.material.set("shader_parameter/new_base1", new_base1)
	sprite.material.set("shader_parameter/new_highlight1", new_highlight1)
