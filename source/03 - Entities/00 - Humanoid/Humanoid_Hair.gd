extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var hairs_short: Array[Resource] = []
@export var hairs_average: Array[Resource] = []
@export var hairs_tall: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
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
