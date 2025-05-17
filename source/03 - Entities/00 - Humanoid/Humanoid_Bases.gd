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
		#If Player is Average
		if !e_customization.is_chub:
			var base = player.get_node("Sprites/Sprite_Base")
			for id in e.NETWORK.players:
				if player.name == str(id):
					base.texture = bases_average[e.NETWORK.players[id].get("height")]
		#If Player is Chubby
		if e_customization.is_chub: texture = bases_chub[e_customization.height_counter]
