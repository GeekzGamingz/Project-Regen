extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var starting_position: Vector2 = Vector2(320, 180)
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
@onready var UI_SPLASH: Control = MAIN.get_node("UserInterface/UI_FullRect/SplashScreen")
@onready var BUTTON_SPAWN: TextureButton = UI_SPLASH.get_node("PopUpContainer/TabContainer/WaitingContainer/SpawnContainer/Button_Spawn")
#Local Nodes
@onready var orphanage_players: Node2D = $Orphanages/Orphanage_Entities/Entities_Players
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
		if id == 1: player.global_position = starting_position
		else: player.global_position = starting_position #Change to Different Spawn Locations
		orphanage_players.call_deferred("add_child", player)
