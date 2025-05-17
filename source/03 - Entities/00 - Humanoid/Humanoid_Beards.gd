extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var beards_short: Array[Resource] = []
@export var beards_average: Array[Resource] = []
@export var beards_tall: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Custom Functions
func check_beard():
	for player in e.get_parent().get_children():
		var beard = player.get_node("Sprites/Sprite_Beard")
		for id in e.NETWORK.players: if player.name == str(id):
			match(e.NETWORK.players[id].get("height")):
				0: beard.texture = beards_short[e.NETWORK.players[id].get("beard")]
				1: beard.texture = beards_average[e.NETWORK.players[id].get("beard")]
				2: beard.texture = beards_tall[e.NETWORK.players[id].get("beard")]
