extends Node2D
#------------------------------------------------------------------------------#
#Variables
var adjustables: Array = []
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_SPLASH: Control = MAIN.get_node("UserInterface/UI_FullRect/SplashScreen")
@onready var CHARACTER: Node2D = UI_SPLASH.get_node("PopUpContainer/TabContainer/CharacterContainer/VBoxContainer/Selection_Character/SubviewportContainer/SubViewport/Sprites_Character")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
@onready var SELECT_COLOR: TabContainer = UI_CUSTOMIZATION.get_node("VBoxContainer/Selection_Color")
@onready var ORPHANAGE_PLAYERS: Node2D = MAIN.get_node("World/Orphanages/Orphanage_Entities/Entities_Players")
#Sprites
@onready var sprite_base: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_Base"
@onready var sprite_ears: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_Ears"
@onready var sprite_arm_right: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_ArmRight"
@onready var sprite_arm_left: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_ArmLeft"
@onready var sprite_leg_right: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_LegRight"
@onready var sprite_leg_left: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_LegLeft"
@onready var sprite_hair: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_Hair"
@onready var sprite_beard: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_Beard"
@onready var sprite_bangs: Sprite2D = $"../../Sprites/Sprites_Body/Sprite_Bangs"
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_CUSTOMIZATION.connect("update_sprites", update_sprites)
	for color in SELECT_COLOR.colors_skin:
		color.connect("update_sprites", update_sprites)
	for color in SELECT_COLOR.colors_hair:
		color.connect("update_sprites", update_sprites)
	for color in SELECT_COLOR.colors_beard:
		color.connect("update_sprites", update_sprites)
	for color in SELECT_COLOR.colors_eyeL:
		color.connect("update_sprites", update_sprites)
	for color in SELECT_COLOR.colors_eyeR:
		color.connect("update_sprites", update_sprites)
	await get_tree().process_frame
	update_sprites()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Update Sprites
func update_sprites(): update_players.rpc()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Players
@rpc("any_peer", "call_local")
func update_players():
	for player in ORPHANAGE_PLAYERS.get_children():
		var custom = player.get_node("Scripts/Entity_Customization")
		for id in NETWORK.players: if player.name == str(id):
			custom.sprite_base.texture = load(NETWORK.players[id].get("sprite_torso"))
			custom.sprite_ears.texture = load(NETWORK.players[id].get("sprite_ears"))
			custom.sprite_arm_right.texture = load(NETWORK.players[id].get("sprite_armR"))
			custom.sprite_arm_left.texture = load(NETWORK.players[id].get("sprite_armL"))
			custom.sprite_leg_right.texture = load(NETWORK.players[id].get("sprite_legR"))
			custom.sprite_leg_left.texture = load(NETWORK.players[id].get("sprite_legL"))
			custom.sprite_hair.texture = load(NETWORK.players[id].get("sprite_hair"))
			custom.sprite_beard.texture = load(NETWORK.players[id].get("sprite_beard"))
			SELECT_COLOR.check_colors()
			var height = int(NETWORK.players[id].get("height"))
			check_heights(height, custom)
#Check Sprite Heights
func check_heights(height, custom):
	custom.adjustables.append_array([
		custom.sprite_ears,
		custom.sprite_hair,
		custom.sprite_bangs,
		custom.sprite_beard
	])
	for sprite in custom.adjustables:
		match(height):
			0: sprite.offset.y = -14.0
			1: sprite.offset.y = -16.0
			2: sprite.offset.y = -18.0
