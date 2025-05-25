extends Node2D
#------------------------------------------------------------------------------#
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var WORLD: Node2D = MAIN.get_node("World")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
@onready var UI_SPLASH: Control = MAIN.get_node("UserInterface/UI_FullRect/SplashScreen")
@onready var BUTTON_SPAWN: TextureButton = UI_SPLASH.get_node("CenterContainer/TabContainer/WaitingContainer/SpawnContainer/Button_Spawn")
#Local Nodes
@onready var orphanage_players: Node2D = $Orphanages/Orphanage_Entities/Entities_Players
@onready var object_plinths: Node2D = $Orphanages/Orphanage_Objects/Object_Plinths
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	NETWORK.connect("spawn_requested", spawn_requested.rpc)
	BUTTON_SPAWN.connect("spawn_requested", spawn_requested.rpc)
#------------------------------------------------------------------------------#
#Custom Signaled Requests
@rpc("any_peer", "call_local")
func spawn_requested():
	for id in NETWORK.players:
		var player_scene = preload("res://source/03 - Entities/00 - Humanoid/01 - Player/Entity_Player.tscn")
		var player = player_scene.instantiate()
		player.name = str(id)
		if id == 1: player.global_position = object_plinths.get_node("Markers/Marker_Host").global_position
		else: player.global_position = object_plinths.get_node("Markers/Marker_Guest1").global_position
		orphanage_players.call_deferred("add_child", player)
