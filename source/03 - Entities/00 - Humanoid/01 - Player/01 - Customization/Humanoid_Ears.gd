extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var ears_short: Array[Resource] = []
@export var ears_average: Array[Resource] = []
@export var ears_tall: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../../.."
@onready var entity_colors: Node2D = e.get_node("Scripts/Entity_Customization/Entity_Colors")
#------------------------------------------------------------------------------#
#Custom Functions
func check_ears():
	for player in e.get_parent().get_children():
		var ears = player.get_node("Sprites/Sprites_Body/Sprite_Ears")
		for id in e.NETWORK.players: if player.name == str(id):
			match(e.NETWORK.players[id].get("height")):
				0: ears.texture = ears_short[e.NETWORK.players[id].get("ears")]
				1: ears.texture = ears_average[e.NETWORK.players[id].get("ears")]
				2: ears.texture = ears_tall[e.NETWORK.players[id].get("ears")]
