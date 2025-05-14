extends Node2D
#------------------------------------------------------------------------------#
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Local Nodes
@onready var spawner_players: MultiplayerSpawner = $Orphanages/Orphanage_Entities/Entities_Players/Spawner_Players
@onready var object_plinths: Node2D = $Orphanages/Orphanage_Objects/Object_Plinths
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:  #BUTTON CONNECT TO SPAWN PLAYER
	#NETWORK.connect("server_found", spawn_player)
	#UI_NETWORK.connect("server_create", spawn_player)
	#UI_NETWORK.connect("client_create", spawn_player)
	UI_NETWORK.connect("spawn_players", set_players)

@rpc("any_peer", "call_local")
func set_players():
	spawner_players.set_spawn_function(set_player)
	print(is_multiplayer_authority())
	if is_multiplayer_authority():
		for player in MAIN.NETWORK.players:
			spawner_players.spawn(0) #MOVE?
		print("Got Here")
	
func set_player(player):
	var player_scene = preload("res://source/03 - Entities/00 - Humanoid/01 - Player/Entity_Player.tscn")
	player = player_scene.instantiate()
	var id = multiplayer.get_unique_id()
	print(id)
	player.set_multiplayer_authority(id)
	player.global_position = object_plinths.get_node("Markers/Marker_Host").global_position
	return player


func _on_button_button_up() -> void:
	print("Got here")
	#rpc("spawn_player")
