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
#Process Function
func _process(_delta: float) -> void: check_colors()
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
	#var button_parent
	#var button_array: Array = []
	#match(colorable):
		#"Skin": button_parent = skin
		#"Hair": button_parent = hair
		#"Beard": button_parent = beard
		#"EyeL": button_parent = eye_left
		#"EyeR": button_parent = eye_right
	#for button in button_parent.get_children(): button_array.append(button)
	#button_array.pick_random().emit_signal("button_up")
#Update Players
func check_colors():
	for player in ORPHANAGE_PLAYERS.get_children():
		for id in NETWORK.players: if player.name == str(id):
			for skin_color in colors_skin:
				if skin_color.name == NETWORK.players[id].get("skin_color"): 
					update_colors(player, skin_color, id)
			for hair_color in colors_hair:
				if hair_color.name == NETWORK.players[id].get("hair_color"):
					update_colors(player, hair_color, id)
			for eye_color in colors_eyeL:
				if eye_color.name == NETWORK.players[id].get("eyeL_color"):
					update_colors(player, eye_color, id)
			for eye_color in colors_eyeR:
				if eye_color.name == NETWORK.players[id].get("eyeR_color"):
					update_colors(player, eye_color, id)
#Update Colors
func update_colors(player, button_color, id):
	match(button_color.sprite_to_color):
		"Skin":
			var sprite_material = player.entity_colors.sprite_base.material
			sprite_material.set("shader_parameter/new_outline1", button_color.new_outline1)
			sprite_material.set("shader_parameter/new_shadow1", button_color.new_shadow1)
			sprite_material.set("shader_parameter/new_base1", button_color.new_base1)
			sprite_material.set("shader_parameter/new_highlight1", button_color.new_highlight1)
		"Hair":
			var sprite_material = player.entity_colors.sprite_hair.material
			#sprite_material.set("shader_parameter/new_outline2", button.new_outline1)
			#sprite_material.set("shader_parameter/new_shadow2", button.new_shadow1)
			#sprite_material.set("shader_parameter/new_base2", button.new_base1)
			#sprite_material.set("shader_parameter/new_highlight2", button.new_highlight1)
			#entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
			sprite_material.set("shader_parameter/new_outline1", button_color.new_outline1)
			sprite_material.set("shader_parameter/new_shadow1", button_color.new_shadow1)
			sprite_material.set("shader_parameter/new_base1", button_color.new_base1)
			sprite_material.set("shader_parameter/new_highlight1", button_color.new_highlight1)
			sprite_material = player.entity_colors.sprite_ears.material
		#entity_colors.sprite_ears.material.set("shader_parameter/new_outline2", new_outline1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_shadow2", new_shadow1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_base2", new_base1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_highlight2", new_highlight1)
		#entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
		#if hair_linked:
			#sprite = entity_colors.sprite_beard
			#entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
		"Eye1":
			var sprite_material = player.entity_colors.sprite_base.material
			sprite_material.set("shader_parameter/new_shadow2", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight2", button_color.new_highlight2)
		"Eye2":
			var sprite_material = player.entity_colors.sprite_base.material
			sprite_material.set("shader_parameter/new_shadow3", button_color.new_shadow2)
			sprite_material.set("shader_parameter/new_highlight3", button_color.new_highlight2)
