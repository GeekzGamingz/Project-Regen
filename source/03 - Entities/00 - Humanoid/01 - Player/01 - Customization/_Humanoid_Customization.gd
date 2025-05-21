extends Node2D
#------------------------------------------------------------------------------#
#Variables
var customize_type: String
#Integers
@export var height_counter: int = 1
@export var ear_counter: int = 0
@export var arm_left_counter: int = 1
@export var arm_right_counter: int = 1
@export var leg_left_counter: int = 1
@export var leg_right_counter: int = 1
@export var hair_counter: int = 0
@export var beard_counter: int = 0
@export var anim_counter: int = 1
#Bools
@export var is_chub: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_CUSTOMIZATION: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization")
@onready var COLOR_SELECT: TabContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization/VBoxContainer/Selection_Color")
#Entity Nodes
@onready var e: Entity = get_parent().get_parent()
#Sprites
@onready var sprite_base: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Base")
@onready var sprite_ears: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_Ears")
@onready var sprite_arm_left: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_ArmLeft")
@onready var sprite_arm_right: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_ArmRight")
@onready var sprite_leg_left: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_LegLeft")
@onready var sprite_leg_right: Sprite2D = e.get_node("Sprites/Sprites_Body/Sprite_LegRight")
@onready var sprite_hair: Sprite2D = e.get_node("Sprites/Sprites_Hair/Sprite_Hair")
@onready var sprite_beard: Sprite2D = e.get_node("Sprites/Sprites_Hair/Sprite_Beard")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	#Connections
	UI_CUSTOMIZATION.connect("visibility_changed", anim_tree_toggle)
	UI_CUSTOMIZATION.connect("uic_height_change", uic_height_change)
	UI_CUSTOMIZATION.connect("uic_ear_change", uic_ear_change)
	UI_CUSTOMIZATION.connect("uic_arm_left_change", uic_arm_left_change)
	UI_CUSTOMIZATION.connect("uic_arm_right_change", uic_arm_right_change)
	UI_CUSTOMIZATION.connect("uic_leg_left_change", uic_leg_left_change)
	UI_CUSTOMIZATION.connect("uic_leg_right_change", uic_leg_right_change)
	UI_CUSTOMIZATION.connect("uic_chub_change", uic_chub_change)
	UI_CUSTOMIZATION.connect("uic_beard_change", uic_beard_change)
	UI_CUSTOMIZATION.connect("uic_hair_change", uic_hair_change)
	UI_CUSTOMIZATION.connect("uic_animation_change", uic_animation_change)
#------------------------------------------------------------------------------#
#Process Function
func _process(_delta: float) -> void:
	if NETWORK.old_players != NETWORK.players:
		check_sprites()
		COLOR_SELECT.check_colors()
	NETWORK.old_players = NETWORK.players.duplicate(true)
#------------------------------------------------------------------------------#
#Custom Functions
func check_sprites() -> void:
	sprite_base.check_base()
	sprite_ears.check_ears()
	sprite_arm_left.check_arm_left()
	sprite_arm_right.check_arm_right()
	sprite_leg_left.check_leg_left()
	sprite_leg_right.check_leg_right()
	sprite_hair.check_hair()
	sprite_beard.check_beard()
	sprite_base.check_animation()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_height_change(scroll):
	customize_type = "Height"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": height_counter -= 1
		"Next": height_counter += 1
	if height_counter == sprite_base.bases_average.size(): height_counter = 0
	elif height_counter < 0: height_counter = sprite_base.bases_average.size() -1
	e.player_serverinfo.update_info.rpc(id, customize_type, height_counter)
#Change Ears
func uic_ear_change(scroll):
	customize_type = "Ears"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": ear_counter -= 1
		"Next": ear_counter += 1
	if ear_counter == sprite_ears.ears_average.size(): ear_counter = 0
	elif ear_counter < 0: ear_counter = sprite_ears.ears_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, ear_counter)
#Change Arm Left
func uic_arm_left_change(scroll):
	customize_type = "ArmLeft"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": arm_left_counter -= 1
		"Next": arm_left_counter += 1
	if arm_left_counter == sprite_arm_left.arms_left_average_average.size(): arm_left_counter = 0
	elif arm_left_counter < 0: arm_left_counter = sprite_arm_left.arms_left_average_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, arm_left_counter)
#Change Arm Right
func uic_arm_right_change(scroll):
	customize_type = "ArmRight"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": arm_right_counter -= 1
		"Next": arm_right_counter += 1
	if arm_right_counter == sprite_arm_right.arms_right_average_average.size(): arm_right_counter = 0
	elif arm_right_counter < 0: arm_right_counter = sprite_arm_right.arms_right_average_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, arm_right_counter)
#Change Leg Left
func uic_leg_left_change(scroll):
	customize_type = "LegLeft"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": leg_left_counter -= 1
		"Next": leg_left_counter += 1
	if leg_left_counter == sprite_leg_left.legs_left_average_average.size(): leg_left_counter = 0
	elif leg_left_counter < 0: leg_left_counter = sprite_leg_left.legs_left_average_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, leg_left_counter)
#Change Leg Right
func uic_leg_right_change(scroll):
	customize_type = "LegRight"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": leg_right_counter -= 1
		"Next": leg_right_counter += 1
	if leg_right_counter == sprite_leg_right.legs_right_average_average.size(): leg_right_counter = 0
	elif leg_right_counter < 0: leg_right_counter = sprite_leg_right.legs_right_average_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, leg_right_counter)
#Change Chub
func uic_chub_change(toggled_on):
	customize_type = "Chub"
	var id = multiplayer.get_unique_id()
	is_chub = toggled_on
	e.player_serverinfo.update_info.rpc(id, customize_type, is_chub)
#Change Hair
func uic_hair_change(scroll):
	customize_type = "Hair"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": hair_counter -= 1
		"Next": hair_counter += 1
	if hair_counter == sprite_hair.hairs_average.size(): hair_counter = 0
	elif hair_counter < 0: hair_counter = sprite_hair.hairs_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, hair_counter)
#Change Beard
func uic_beard_change(scroll):
	customize_type = "Beard"
	var id = multiplayer.get_unique_id()
	match(scroll):
		"Previous": beard_counter -= 1
		"Next": beard_counter += 1
	if beard_counter == sprite_beard.beards_average.size(): beard_counter = 0
	elif beard_counter < 0: beard_counter = sprite_beard.beards_average.size() - 1
	e.player_serverinfo.update_info.rpc(id, customize_type, beard_counter)
#Change Animation
func uic_animation_change(scroll):
	customize_type = "Animation"
	var id = multiplayer.get_unique_id()
	var animation_list = e.sprite_player.get_animation_list()
	e.anim_tree.active = false
	match(scroll):
		"Previous": anim_counter -= 1
		"Next": anim_counter += 1
	if anim_counter < 0: anim_counter = animation_list.size() - 1
	elif anim_counter == animation_list.size(): anim_counter = 1
	e.player_serverinfo.update_info.rpc(id, customize_type, anim_counter)
	sprite_base.check_animation()
#Animation Tree Toggle
func anim_tree_toggle(): e.anim_tree.active = !e.anim_tree.active
