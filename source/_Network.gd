extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal server_found
signal message_join
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Variables
#Exported Variables
@export var port: int = 60005
@export var max_players: int = 5
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	multiplayer.connected_to_server.connect(connection_successful)
	UI_NETWORK.connect("server_create", server_create)
	UI_NETWORK.connect("client_create", client_create)
#------------------------------------------------------------------------------#
#Custom Functions
func server_joined(username):
	var peer_id = multiplayer.get_unique_id()
	if peer_id == 1: print("Host Connected: ", username,  " [", peer_id, "]")
	else: print("Client Connected: ", username, " [", peer_id, "]")
	emit_signal("server_found", username)
	UI_NETWORK.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Create New Server
func server_create(username):
	var host = ENetMultiplayerPeer.new()
	host.create_server(port, max_players)
	multiplayer.multiplayer_peer = host
	print("[!HOST CLIENT CREATED!]")
	server_joined(username)
#Create Client Connection
func client_create(username, ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	print("[!GUEST CLIENT CREATED!]")
	server_joined(username)
#On Successful Connection
func connection_successful(): emit_signal("message_join")
