extends Node2D
#------------------------------------------------------------------------------#
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
#Entity Nodes
@onready var e: Entity = $"../../.."
#Sprites
@onready var sprite_base: Sprite2D = e.get_node("Sprites/Sprite_Base")
@onready var sprite_hair: Sprite2D = e.get_node("Sprites/Sprite_Hair")
@onready var sprite_ears: Sprite2D = e.get_node("Sprites/Sprite_Ears")
@onready var sprite_beard: Sprite2D = e.get_node("Sprites/Sprite_Beard")
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
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Colors
func send_colors(color_id, sprite_to_color, eyes_linked, hair_linked):
	if e.is_multiplayer_authority():
		match(sprite_to_color):
			"Skin": sprite_base.save_skin(color_id)
			"Hair": sprite_hair.save_hair(color_id, hair_linked)
			"Beard": sprite_beard.save_beard(color_id, hair_linked)
			"Eye1", "Eye2":
				var lateral = sprite_to_color
				sprite_base.save_eyes(color_id, eyes_linked, lateral)
