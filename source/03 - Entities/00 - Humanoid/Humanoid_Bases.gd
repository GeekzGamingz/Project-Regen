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
		var base = player.get_node("Sprites/Sprite_Base")
		for id in e.NETWORK.players:
			#If Player is Average
			if !e.NETWORK.players[id].get("chub"): if player.name == str(id):
				base.texture = bases_average[e.NETWORK.players[id].get("height")]
			#If Player is Chubby
			if e.NETWORK.players[id].get("chub"): if player.name == str(id):
				base.texture = bases_chub[e.NETWORK.players[id].get("height")]
#Check Animations
func check_animation():
	for player in e.get_parent().get_children():
		for id in e.NETWORK.players: if player.name == str(id):
			var animation_list = e.sprite_player.get_animation_list()
			var anim_desired = animation_list.get(e.NETWORK.players[id].get("animation"))
			player.sprite_player.play(anim_desired)
