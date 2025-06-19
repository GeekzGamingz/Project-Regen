extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
var colors_skin: Array = []
var colors_hair: Array = []
var colors_beard: Array = []
var colors_eyeL: Array = []
var colors_eyeR: Array = []
#OnReady Variabels
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
@onready var COLOR_SELECT: TabContainer = UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color")
#Button Containers
@onready var skin: GridContainer = COLOR_SELECT.get_node("Skin/Grid_Skin")
@onready var hair: GridContainer = COLOR_SELECT.get_node("Hair/Top/Grid_Top")
@onready var beard: GridContainer = COLOR_SELECT.get_node("Hair/Facial/Grid_Facial")
@onready var eye_left: GridContainer = COLOR_SELECT.get_node("Eyes/Left/Grid_Left")
@onready var eye_right: GridContainer = COLOR_SELECT.get_node("Eyes/Right/Grid_Right")
#Local Nodes
@onready var sprites_dictionary: Node2D = $"../Sprites_Dictionary"
#Sprites
@onready var sprite_base: Sprite2D = $"../Sprites_Body/Sprite_Base"
@onready var sprite_arm_left: Sprite2D = $"../Sprites_Body/Sprite_ArmLeft"
@onready var sprite_arm_right: Sprite2D = $"../Sprites_Body/Sprite_ArmRight"
@onready var sprite_leg_left: Sprite2D = $"../Sprites_Body/Sprite_LegLeft"
@onready var sprite_leg_right: Sprite2D = $"../Sprites_Body/Sprite_LegRight"
@onready var sprite_hair: Sprite2D = $"../Sprites_Body/Sprite_Hair"
@onready var sprite_ears: Sprite2D = $"../Sprites_Body/Sprite_Ears"
@onready var sprite_beard: Sprite2D = $"../Sprites_Body/Sprite_Beard"
@onready var sprite_bangs: Sprite2D = $"../Sprites_Body/Sprite_Bangs"
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color/Skin/Grid_Skin").get_children():
		button.connect("send_colors", send_colors)
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color/Eyes/Left/Grid_Left").get_children():
		button.connect("send_colors", send_colors)
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color/Eyes/Right/Grid_Right").get_children():
		button.connect("send_colors", send_colors)
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color/Hair/Top/Grid_Top").get_children():
		button.connect("send_colors", send_colors)
	for button in UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color/Hair/Facial/Grid_Facial").get_children():
		button.connect("send_colors", send_colors)
	assign_colors()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func send_colors(color_id, sprite_to_color, eyes_linked, hair_linked):
	match(sprite_to_color):
		"Skin":
			sprites_dictionary.sprite_info["skin_color"] = color_id
		"Hair":
			sprites_dictionary.sprite_info["hair_color"] = color_id
			if hair_linked: sprites_dictionary.sprite_info["beard_color"] = color_id
		"Beard":
			sprites_dictionary.sprite_info["beard_color"] = color_id
			if hair_linked: sprites_dictionary.sprite_info["hair_color"] = color_id
		"Eye1":
			sprites_dictionary.sprite_info["eyeR_color"] = color_id
			if eyes_linked: sprites_dictionary.sprite_info["eyeL_color"] = color_id
		"Eye2":
			sprites_dictionary.sprite_info["eyeL_color"] = color_id
			if eyes_linked: sprites_dictionary.sprite_info["eyeR_color"] = color_id
	check_colors()
#------------------------------------------------------------------------------#
#Custom Functions
#Assign Colors
func assign_colors():
	for color in skin.get_children(): colors_skin.append(color)
	for color in hair.get_children(): colors_hair.append(color)
	for color in beard.get_children(): colors_beard.append(color)
	for color in eye_left.get_children(): colors_eyeL.append(color)
	for color in eye_right.get_children(): colors_eyeR.append(color)
#Update Players
func check_colors():
	for skin_color in colors_skin:
		if skin_color.name == sprites_dictionary.sprite_info["skin_color"]: 
			update_colors(skin_color)
	for hair_color in colors_hair:
		if hair_color.name == sprites_dictionary.sprite_info["hair_color"]:
			update_colors(hair_color)
	for beard_color in colors_beard:
		if beard_color.name == sprites_dictionary.sprite_info["beard_color"]:
			update_colors(beard_color)
	for eye_color in colors_eyeL:
		if eye_color.name == sprites_dictionary.sprite_info["eyeL_color"]:
			update_colors(eye_color)
	for eye_color in colors_eyeR:
		if eye_color.name == sprites_dictionary.sprite_info["eyeR_color"]:
			update_colors(eye_color)
#Update Colors
func update_colors(button_color):
	match(button_color.sprite_to_color):
		"Skin":
			var sprite_material = sprite_base.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_ears.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_arm_left.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_arm_right.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_leg_left.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_leg_right.material
			update_primary(sprite_material, button_color)
			sprite_material = MAIN.UI_CURSOR_ICON.material
			update_primary(sprite_material, button_color)
		"Eye1":
			var sprite_material = sprite_base.material
			sprite_material.set("shader_parameter/new_shadow2", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight2", button_color.new_highlight2)
		"Eye2":
			var sprite_material = sprite_base.material
			sprite_material.set("shader_parameter/new_shadow3", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight3", button_color.new_highlight2)
		"Hair":
			var sprite_material = sprite_hair.material
			update_primary(sprite_material, button_color)
		"Beard":
			var sprite_material = sprite_beard.material
			update_primary(sprite_material, button_color)
			sprite_material = sprite_ears.material
			sprite_material.set("shader_parameter/new_outline2", button_color.new_outline1)
			sprite_material.set("shader_parameter/new_shadow2", button_color.new_shadow1)
			sprite_material.set("shader_parameter/new_base2", button_color.new_shadow1)
			sprite_material.set("shader_parameter/new_highlight2", button_color.new_highlight1)
#Update Primary Colors
func update_primary(sprite_material, button_color):
	sprite_material.set("shader_parameter/new_outline1", button_color.new_outline1)
	sprite_material.set("shader_parameter/new_shadow1", button_color.new_shadow1)
	sprite_material.set("shader_parameter/new_base1", button_color.new_base1)
	sprite_material.set("shader_parameter/new_highlight1", button_color.new_highlight1)
