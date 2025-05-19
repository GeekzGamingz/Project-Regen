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
#Save Hair Colors
func save_hair(color_id, hair_linked):
	var id = multiplayer.get_unique_id()
	var customize_type = "HairColor"
	e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
	if hair_linked:
		customize_type = "BeardColor"
		e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
