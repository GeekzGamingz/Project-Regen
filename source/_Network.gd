extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal server_found
signal message_join
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected
#------------------------------------------------------------------------------#
#Variables
#Dictionaries
var players: Dictionary = {}
var player_info: Dictionary = {"name": "Name"}
var players_online: int = 0
#Exported Variables
@export var port: int = 60005
@export var max_players: int = 5
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", server_create)
	UI_NETWORK.connect("client_create", client_create)
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_successful)
	multiplayer.connection_failed.connect(_on_connection_unsuccessful)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
#------------------------------------------------------------------------------#
#Custom Functions
func server_joined(username):
	var peer_id = multiplayer.get_unique_id()
	if peer_id == 1: print("Host Connected: ", username,  " [", peer_id, "]")
	else: print("Client Connected: ", username, " [", peer_id, "]")
	emit_signal("server_found", username)
	UI_NETWORK.set_deferred("visible", false)
#Register Player
@rpc("any_peer", "reliable")
func register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)
	rpc("player_update", +1)
#Update Players Online
@rpc("any_peer", "call_local")
func player_update(value): players_online += value
#------------------------------------------------------------------------------#
#Signaled Functions
#Player Connected/Disconnected
func _on_player_connected(id): register_player.rpc_id(id, player_info)
func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)
	rpc("player_update", -1)
#Connection Successful/Unsuccessful
func _on_connection_successful(): 
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)
	emit_signal("message_join")
func _on_connection_unsuccessful(): multiplayer.multiplayer_peer = null
#Server Disconnected
func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Create New Server
func server_create(username):
	var host = ENetMultiplayerPeer.new()
	host.create_server(port, max_players)
	multiplayer.multiplayer_peer = host
	player_info["name"] = username
	players[1] = player_info
	player_connected.emit(1, player_info)
	server_joined(username)
#Create Client Connection
func client_create(username, ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	player_info["name"] = username
	multiplayer.multiplayer_peer = peer
	server_joined(username)
