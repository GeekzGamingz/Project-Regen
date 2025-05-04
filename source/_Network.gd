extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal server_found
signal join_message
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Variables
#Exported Variables
@export var port: int = 60005
@export var max_players: int = 4
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", server_create)
	UI_NETWORK.connect("client_create", client_create)
#------------------------------------------------------------------------------#
#Custom Functions
func server_joined(username):
	var peer_id = multiplayer.get_unique_id()
	if peer_id == 1: print("Host Connected: ", username,  " [", peer_id, "]")
	else: print("Client Connected: ", username, " [", peer_id, "]")
	multiplayer.peer_connected.connect(connection_output)
	emit_signal("server_found", username)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Create New Server
func server_create(username):
	var host = ENetMultiplayerPeer.new()
	host.create_server(port, max_players)
	get_tree().set_multiplayer(SceneMultiplayer.new(), get_path())
	multiplayer.multiplayer_peer = host
	print("[!SERVER CREATED!]")
	server_joined(username)
#Create Client Connection
func client_create(username, ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	get_tree().set_multiplayer(SceneMultiplayer.new(), get_path())
	multiplayer.multiplayer_peer = peer
	server_joined(username)
#Connection Output
func connection_output(id: int):
	emit_signal("join_message")
	print("Peer Connected ", id)
