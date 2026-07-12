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
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
@onready var COLOR_SELECT: TabContainer = UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color")
#Button Containers
@onready var skin: GridContainer = COLOR_SELECT.get_node("Skin/Grid_Skin")
@onready var hair: GridContainer = COLOR_SELECT.get_node("Hair/Top/Grid_Top")
@onready var beard: GridContainer = COLOR_SELECT.get_node("Hair/Facial/Grid_Facial")
@onready var eye_left: GridContainer = COLOR_SELECT.get_node("Eyes/Left/Grid_Left")
@onready var eye_right: GridContainer = COLOR_SELECT.get_node("Eyes/Right/Grid_Right")
#Local Nodes
@onready var e: Entity = $"../../.."
#Sprites
@onready var sprite_base: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Base")
@onready var sprite_ears: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Ears")
@onready var sprite_arm_left: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_ArmLeft")
@onready var sprite_arm_right: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_ArmRight")
@onready var sprite_leg_left: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_LegLeft")
@onready var sprite_leg_right: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_LegRight")
@onready var sprite_hair: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Hair")
@onready var sprite_beard: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Beard")
@onready var sprite_bangs: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Bangs")
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
	update_colors.rpc(color_id, sprite_to_color, eyes_linked, hair_linked)
#------------------------------------------------------------------------------#
#Custom Functions
#Assign Colors
func assign_colors():
	for color in skin.get_children(): colors_skin.append(color)
	for color in hair.get_children(): colors_hair.append(color)
	for color in beard.get_children(): colors_beard.append(color)
	for color in eye_left.get_children(): colors_eyeL.append(color)
	for color in eye_right.get_children(): colors_eyeR.append(color)
#Update Colors
@rpc("any_peer", "call_local")
func update_colors(color_id, sprite_to_color, eyes_linked, hair_linked):
	var id = multiplayer.get_remote_sender_id()
	match(sprite_to_color):
		"Skin": NETWORK.players[id].set("skin_color", color_id)
		"Hair":
			NETWORK.players[id].set("hair_color", color_id)
			if hair_linked: NETWORK.players[id].set("beard_color", color_id)
		"Beard":
			NETWORK.players[id].set("beard_color", color_id)
			if hair_linked: NETWORK.players[id].set("hair_color", color_id)
		"Eye1":
			NETWORK.players[id].set("eyeR_color", color_id)
			if eyes_linked: NETWORK.players[id].set("eyeL_color", color_id)
		"Eye2":
			NETWORK.players[id].set("eyeL_color", color_id)
			if eyes_linked: NETWORK.players[id].set("eyeR_color", color_id)
