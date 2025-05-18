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
func send_colors(
	sprite_to_color, eyes_linked, hair_linked, #Identifiers
	new_outline1, new_shadow1, new_base1, new_highlight1, #Color One
	_new_outline2, new_shadow2, _new_base2, new_highlight2, #Color Two
	_new_outline3, _new_shadow3, _new_base3, _new_highlight3, #Color Two
	):
	if e.is_multiplayer_authority():
		var sprite = Sprite2D
		match(sprite_to_color):
			"Skin":
				sprite = sprite_base
				sprite_base.color_skin(
					sprite, #Identifiers
					new_outline1, new_shadow1, new_base1, new_highlight1, #Color One
				)
			"Hair":
				sprite = sprite_hair
				sprite_hair.color_hair(
					sprite, hair_linked, #Identifiers
					new_outline1, new_shadow1, new_base1, new_highlight1 #Color One
				)
			"Beard":
				sprite = sprite_beard
				sprite_beard.color_beard(
					sprite, hair_linked, #Identifiers
					new_outline1, new_shadow1, new_base1, new_highlight1 #Color One
				)
			"Eye1", "Eye2":
				sprite = sprite_base
				var lateral = sprite_to_color
				sprite_base.color_eyes(
					sprite, eyes_linked, lateral, #Identifiers
					new_shadow2, new_highlight2, #Color Two
				)
#Update Colors
func update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1):
	sprite.material.set("shader_parameter/new_outline1", new_outline1)
	sprite.material.set("shader_parameter/new_shadow1", new_shadow1)
	sprite.material.set("shader_parameter/new_base1", new_base1)
	sprite.material.set("shader_parameter/new_highlight1", new_highlight1)
