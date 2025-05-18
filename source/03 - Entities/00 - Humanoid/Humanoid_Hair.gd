extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var hairs_short: Array[Resource] = []
@export var hairs_average: Array[Resource] = []
@export var hairs_tall: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var entity_colors: Node2D = $"../../Scripts/Entity_Customization/Entity_Colors"
#------------------------------------------------------------------------------#
#Custom Functions
func check_hair():
	for player in e.get_parent().get_children():
		var hair = player.get_node("Sprites/Sprite_Hair")
		for id in e.NETWORK.players: if player.name == str(id):
			match(e.NETWORK.players[id].get("height")):
				0: hair.texture = hairs_short[e.NETWORK.players[id].get("hair")]
				1: hair.texture = hairs_average[e.NETWORK.players[id].get("hair")]
				2: hair.texture = hairs_tall[e.NETWORK.players[id].get("hair")]
#Check Colors
func save_hair(color_id):
	var customize_type = "HairColor"
	if e.is_multiplayer_authority():
		e.player_serverinfo.update_info.rpc(
			multiplayer.get_unique_id(),
			customize_type,
			color_id
		)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_outline2", new_outline1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_shadow2", new_shadow1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_base2", new_base1)
		#entity_colors.sprite_ears.material.set("shader_parameter/new_highlight2", new_highlight1)
		#entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
		#if hair_linked:
			#sprite = entity_colors.sprite_beard
			#entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
