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
#Entity Nodes
@onready var e: Entity = get_parent().get_parent()
#Sprites
@onready var sprite_base: Sprite2D = e.get_node("Sprites/Sprite_Base")
@onready var sprite_hair: Sprite2D = e.get_node("Sprites/Sprite_HairBack")
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
#Process Function
func _process(_delta: float) -> void: check_sprites()
#------------------------------------------------------------------------------#
#Custom Functions
func check_sprites() -> void:
	if e.is_multiplayer_authority():
		sprite_base.check_base()
		sprite_hair.check_hair()
		sprite_ears.check_ears()
		sprite_beard.check_beard()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Hair
func uic_hair_change(scroll):
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": hair_counter -= 1
			"Next": hair_counter += 1
		if hair_counter == sprite_hair.hairs_average.size(): hair_counter = 0
		elif hair_counter < 0: hair_counter = sprite_hair.hairs_average.size() - 1
#Change Ears
func uic_ear_change(scroll):
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": ear_counter -= 1
			"Next": ear_counter += 1
		if ear_counter == sprite_ears.ears_average.size(): ear_counter = 0
		elif ear_counter < 0: ear_counter = sprite_ears.ears_average.size() - 1
#Change Beard
func uic_beard_change(scroll):
	if e.is_multiplayer_authority():
		match(scroll):
			"Previous": beard_counter -= 1
			"Next": beard_counter += 1
		if beard_counter == sprite_beard.beards_average.size(): beard_counter = 0
		elif beard_counter < 0: beard_counter = sprite_beard.beards_average.size() - 1
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
			height_counter)
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
	if e.is_multiplayer_authority():
		var animation_list = e.sprite_player.get_animation_list()
		e.anim_tree.active = false
		match(scroll):
			"Previous": anim_counter -= 1
			"Next": anim_counter += 1
		if anim_counter < 0: anim_counter = animation_list.size() - 1
		elif anim_counter == animation_list.size(): anim_counter = 1
		var anim_desired = (animation_list.get(anim_counter))
		e.sprite_player.play(anim_desired)
#Animation Tree Toggle
func anim_tree_toggle(): e.anim_tree.active = !e.anim_tree.active
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
				sprite_ears.material.set("shader_parameter/new_outline1", new_outline1)
				sprite_ears.material.set("shader_parameter/new_shadow1", new_shadow1)
				sprite_ears.material.set("shader_parameter/new_base1", new_base1)
				sprite_ears.material.set("shader_parameter/new_highlight1", new_highlight1)
				update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
			"Hair":
				sprite = sprite_hair
				sprite_ears.material.set("shader_parameter/new_outline2", new_outline1)
				sprite_ears.material.set("shader_parameter/new_shadow2", new_shadow1)
				sprite_ears.material.set("shader_parameter/new_base2", new_base1)
				sprite_ears.material.set("shader_parameter/new_highlight2", new_highlight1)
				update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
				if hair_linked:
					sprite = sprite_beard
					update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
			"Beard":
				sprite = sprite_beard
				update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
				if hair_linked:
					sprite_ears.material.set("shader_parameter/new_outline2", new_outline1)
					sprite_ears.material.set("shader_parameter/new_shadow2", new_shadow1)
					sprite_ears.material.set("shader_parameter/new_base2", new_base1)
					sprite_ears.material.set("shader_parameter/new_highlight2", new_highlight1)
					sprite = sprite_hair
					update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
			"Eye1":
				sprite = sprite_base
				sprite.material.set("shader_parameter/new_shadow2", new_shadow2)
				sprite.material.set("shader_parameter/new_highlight2", new_highlight2)
				if eyes_linked:
					sprite.material.set("shader_parameter/new_shadow3", new_shadow2)
					sprite.material.set("shader_parameter/new_highlight3", new_highlight2)
			"Eye2":
				sprite = sprite_base
				sprite.material.set("shader_parameter/new_shadow3", new_shadow2)
				sprite.material.set("shader_parameter/new_highlight3", new_highlight2)
				if eyes_linked:
					sprite.material.set("shader_parameter/new_shadow2", new_shadow2)
					sprite.material.set("shader_parameter/new_highlight2", new_highlight2)
#Update Colors
func update_colors(sprite, new_outline1, new_shadow1, new_base1, new_highlight1):
	sprite.material.set("shader_parameter/new_outline1", new_outline1)
	sprite.material.set("shader_parameter/new_shadow1", new_shadow1)
	sprite.material.set("shader_parameter/new_base1", new_base1)
	sprite.material.set("shader_parameter/new_highlight1", new_highlight1)
