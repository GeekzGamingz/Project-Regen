extends Node2D
#------------------------------------------------------------------------------#
#Signals
#signal info_updated(id, player_info)
#Variables
@onready var e: CharacterBody2D = get_parent().get_parent()
@onready var orphanage_players: Node2D = e.get_parent()
@onready var e_customization: Node2D = $"../Entity_Customization"
#------------------------------------------------------------------------------#
@rpc("any_peer", "call_local", "reliable")
func update_height(id, new_height): e.NETWORK.players[id].set("height", new_height)
#func update_info(id, new_info): e.NETWORK.players[id].set("height", new_info)
#CHANGE TO MATCH STATEMENT?
	
	
