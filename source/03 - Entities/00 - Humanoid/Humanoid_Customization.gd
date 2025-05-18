extends Node2D
#------------------------------------------------------------------------------#
#Variables
var customize_type: String
#Dictionaries
var old_info: Dictionary = {}
#Integers
@export var hair_counter: int = 0
@export var ear_counter: int = 0
@export var beard_counter: int = 0
@export var anim_counter: int = 1
@export var height_counter: int = 1
#Bools
@export var is_chub: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
@onready var COLOR_SELECT: TabContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization/VBoxContainer/Selection_Color")
#Entity Nodes
@onready var e: Entity = get_parent().get_parent()
#Sprites
@onready var sprite_base: Sprite2D = e.get_node("Sprites/Sprite_Base")
@onready var sprite_hair: Sprite2D = e.get_node("Sprites/Sprite_Hair")
@onready var sprite_ears: Sprite2D = e.get_node("Sprites/Sprite_Ears")
@onready var sprite_beard: Sprite2D = e.get_node("Sprites/Sprite_Beard")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	#Connections
	UI_CUSTOMIZATION.connect("visibility_changed", anim_tree_toggle)
	UI_CUSTOMIZATION.connect("uic_hair_change", uic_hair_change)
	UI_CUSTOMIZATION.connect("uic_ear_change", uic_ear_change)
	UI_CUSTOMIZATION.connect("uic_beard_change", uic_beard_change)
	UI_CUSTOMIZATION.connect("uic_height_change", uic_height_change)
	UI_CUSTOMIZATION.connect("uic_chub_change", uic_chub_change)
	UI_CUSTOMIZATION.connect("uic_animation_change", uic_animation_change)
#------------------------------------------------------------------------------#
#Process Function
func _process(_delta: float) -> void: check_sprites()
#------------------------------------------------------------------------------#
#Custom Functions
func check_sprites() -> void:
	if e.is_multiplayer_authority():
		sprite_base.check_base()
		sprite_base.check_animation()
		sprite_hair.check_hair()
		sprite_ears.check_ears()
		sprite_beard.check_beard()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Hair
func uic_hair_change(scroll):
	customize_type = "Hair"
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": hair_counter -= 1
			"Next": hair_counter += 1
		if hair_counter == sprite_hair.hairs_average.size(): hair_counter = 0
		elif hair_counter < 0: hair_counter = sprite_hair.hairs_average.size() - 1
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			hair_counter
		)
#Change Ears
func uic_ear_change(scroll):
	customize_type = "Ears"
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": ear_counter -= 1
			"Next": ear_counter += 1
		if ear_counter == sprite_ears.ears_average.size(): ear_counter = 0
		elif ear_counter < 0: ear_counter = sprite_ears.ears_average.size() - 1
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			ear_counter
		)
#Change Beard
func uic_beard_change(scroll):
	customize_type = "Beard"
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": beard_counter -= 1
			"Next": beard_counter += 1
		if beard_counter == sprite_beard.beards_average.size(): beard_counter = 0
		elif beard_counter < 0: beard_counter = sprite_beard.beards_average.size() - 1
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			beard_counter
		)
#Change Height
func uic_height_change(scroll):
	customize_type = "Height"
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": height_counter -= 1
			"Next": height_counter += 1
		if height_counter == sprite_base.bases_average.size(): height_counter = 0
		elif height_counter < 0: height_counter = sprite_base.bases_average.size() -1
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			height_counter
		)
#Change Chub
func uic_chub_change(toggled_on):
	customize_type = "Chub"
	if e.is_multiplayer_authority():
		is_chub = toggled_on
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			is_chub
		)
#Change Animation
func uic_animation_change(scroll):
	customize_type = "Animation"
	if e.is_multiplayer_authority():
		var animation_list = e.sprite_player.get_animation_list()
		e.anim_tree.active = false
		match(scroll):
			"Previous": anim_counter -= 1
			"Next": anim_counter += 1
		if anim_counter < 0: anim_counter = animation_list.size() - 1
		elif anim_counter == animation_list.size(): anim_counter = 1
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			anim_counter
		)
		sprite_base.check_animation()
#Animation Tree Toggle
func anim_tree_toggle(): e.anim_tree.active = !e.anim_tree.active
