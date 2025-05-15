extends Node2D
#------------------------------------------------------------------------------#
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
@onready var BUTTON_SPAWN: TextureButton = MAIN.get_node("UserInterface/UI_FullRect/CenterContainer/Button_Spawn")
#Local Nodes
@onready var spawner_players: MultiplayerSpawner = $Orphanages/Orphanage_Entities/Entities_Players/Spawner_Players
@onready var object_plinths: Node2D = $Orphanages/Orphanage_Objects/Object_Plinths
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	BUTTON_SPAWN.connect("spawn_requested", spawn_requested.rpc)
	NETWORK.connect("server_found", server_found)
#------------------------------------------------------------------------------#
#Custom Signaled Requests
@rpc("any_peer", "call_local")
func spawn_requested():
	for id in NETWORK.players:
		var player_scene = preload("res://source/03 - Entities/00 - Humanoid/01 - Player/Entity_Player.tscn")
		var player = player_scene.instantiate()
		player.set_multiplayer_authority(id)
		player.name = str(id)
		if id == 1: player.global_position = object_plinths.get_node("Markers/Marker_Host").global_position
		else: player.global_position = object_plinths.get_node("Markers/Marker_Guest1").global_position
		spawner_players.call_deferred("add_child", player)
#Server Found
func server_found(username): print(username, ": Found the World!")
