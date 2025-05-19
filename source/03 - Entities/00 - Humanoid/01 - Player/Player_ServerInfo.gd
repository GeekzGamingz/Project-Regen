extends Node2D
#------------------------------------------------------------------------------#
#Variables
@onready var e: CharacterBody2D = get_parent().get_parent()
@onready var orphanage_players: Node2D = e.get_parent()
@onready var e_customization: Node2D = $"../Entity_Customization"
#------------------------------------------------------------------------------#
@rpc("any_peer", "call_local", "reliable")
func update_info(id, customize_type, new_info):
	match(customize_type):
		"Height": e.NETWORK.players[id].set("height", new_info)
		"Chub": e.NETWORK.players[id].set("chub", new_info)
		"Animation": e.NETWORK.players[id].set("animation", new_info)
		"Beard": e.NETWORK.players[id].set("beard", new_info)
		"BeardColor": e.NETWORK.players[id].set("beard_color", new_info)
		"Ears": e.NETWORK.players[id].set("ears", new_info)
		"Hair": e.NETWORK.players[id].set("hair", new_info)
		"HairColor": e.NETWORK.players[id].set("hair_color", new_info)
		"Skin": e.NETWORK.players[id].set("skin_color", new_info)
		"EyeLeft": e.NETWORK.players[id].set("eyeL_color", new_info)
		"EyeRight": e.NETWORK.players[id].set("eyeR_color", new_info)
