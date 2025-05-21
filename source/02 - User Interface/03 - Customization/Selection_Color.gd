extends TabContainer
#------------------------------------------------------------------------------#
#Variables
var colors_skin: Array = []
var colors_hair: Array = []
var colors_beard: Array = []
var colors_eyeL: Array = []
var colors_eyeR: Array = []
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var ORPHANAGE_PLAYERS: Node2D = MAIN.get_node("World/Orphanages/Orphanage_Entities/Entities_Players")
#Local Nodes
@onready var skin: GridContainer = $Skin/Grid_Skin
@onready var hair: GridContainer = $Hair/Top/Grid_Top
@onready var beard: GridContainer = $Hair/Facial/Grid_Facial
@onready var eye_left: GridContainer = $Eyes/Left/Grid_Left
@onready var eye_right: GridContainer = $Eyes/Right/Grid_Right
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: assign_colors()
#------------------------------------------------------------------------------#
#Custom Functions
#Assign Colors
func assign_colors():
	for color in skin.get_children(): colors_skin.append(color)
	for color in hair.get_children(): colors_hair.append(color)
	for color in beard.get_children(): colors_beard.append(color)
	for color in eye_left.get_children(): colors_eyeL.append(color)
	for color in eye_right.get_children(): colors_eyeR.append(color)
#Random Color
func random_colors():
	randomize()
	#Assign Random Dict Variables Here.
#Update Players
func check_colors():
	for player in ORPHANAGE_PLAYERS.get_children():
		for id in NETWORK.players: if player.name == str(id):
			for skin_color in colors_skin:
				if skin_color.name == NETWORK.players[id].get("skin_color"): 
					update_colors(player, skin_color)
			for hair_color in colors_hair:
				if hair_color.name == NETWORK.players[id].get("hair_color"):
					update_colors(player, hair_color)
			for beard_color in colors_beard:
				if beard_color.name == NETWORK.players[id].get("beard_color"):
					update_colors(player, beard_color)
			for eye_color in colors_eyeL:
				if eye_color.name == NETWORK.players[id].get("eyeL_color"):
					update_colors(player, eye_color)
			for eye_color in colors_eyeR:
				if eye_color.name == NETWORK.players[id].get("eyeR_color"):
					update_colors(player, eye_color)
#Update Colors
func update_colors(player, button_color):
	match(button_color.sprite_to_color):
		"Skin":
			var sprite_material = player.entity_colors.sprite_base.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_ears.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_arm_left.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_arm_right.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_leg_left.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_leg_right.material
			update_primary(sprite_material, button_color)
		"Hair":
			var sprite_material = player.entity_colors.sprite_hair.material
			update_primary(sprite_material, button_color)
		"Eye1":
			var sprite_material = player.entity_colors.sprite_base.material
			sprite_material.set("shader_parameter/new_shadow2", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight2", button_color.new_highlight2)
		"Eye2":
			var sprite_material = player.entity_colors.sprite_base.material
			sprite_material.set("shader_parameter/new_shadow3", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight3", button_color.new_highlight2)
		"Beard":
			var sprite_material = player.entity_colors.sprite_beard.material
			update_primary(sprite_material, button_color)
			sprite_material = player.entity_colors.sprite_ears.material
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
