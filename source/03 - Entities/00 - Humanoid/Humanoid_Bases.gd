extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Check Base Texture
func check_base():
	for player in e.get_parent().get_children():
		for id in e.NETWORK.players:
			#If Player is Average
			if !e.NETWORK.players[id].get("chub"):
				var base = player.get_node("Sprites/Sprite_Base")
				if player.name == str(id):
					base.texture = bases_average[e.NETWORK.players[id].get("height")]
			#If Player is Chubby
			if e.NETWORK.players[id].get("chub"):
				var base = player.get_node("Sprites/Sprite_Base")
				if player.name == str(id):
					base.texture = bases_chub[e.NETWORK.players[id].get("height")]
