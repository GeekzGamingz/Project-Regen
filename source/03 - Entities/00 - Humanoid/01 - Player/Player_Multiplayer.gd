extends Node2D
#------------------------------------------------------------------------------#
#Variables
@onready var e: CharacterBody2D = get_parent().get_parent()
@onready var orphanage_players: Node2D = e.get_parent()
@onready var e_customization: Node2D = $"../Entity_Customization"
#------------------------------------------------------------------------------#
@rpc("any_peer", "call_local")
func update_players():
	print(multiplayer.get_unique_id(), ": RPC Initiated")
	
	e.NETWORK.players[multiplayer.get_unique_id()].set("height", e_customization.height_counter)
	#for player in e.NETWORK.players:
		#if player == multiplayer.get_unique_id():
			#var p_info = e.NETWORK.players[multiplayer.get_unique_id()]
			#p_info.set("height", e_customization.height_counter)
			#print(p_info)


	e.get_node("Scripts/Entity_Customization").check_sprites()

	print(e.NETWORK.players)
