extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal server_found
signal spawn_requested
signal message_join
signal message_leave
signal peer_connected(id, player_info)
signal peer_disconnected(id)
signal server_disconnected
#------------------------------------------------------------------------------#
#Variables
#Booleans
var single_player: bool = false
#Dictionaries
var players: Dictionary = {}
var old_players: Dictionary = {}
var players_online: int = 1
#Exported Variables
@export var port: int = 42069
@export var max_players: int = 4
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
@onready var UI_SPLASH: Control = MAIN.get_node("UserInterface/UI_FullRect/SplashScreen")
@onready var BUTTON_NEWGAME: Button = UI_SPLASH.get_node("MenuContainer/SubMenus/SinglePlayer/Button_NewGame")
@onready var BUTTON_HOSTGAME: Button = UI_SPLASH.get_node("MenuContainer/SubMenus/Multiplayer/Button_HostGame")
@onready var BUTTON_JOINGAME: Button = UI_SPLASH.get_node("MenuContainer/SubMenus/Multiplayer/Button_JoinGame")
@onready var WAITING_ROOM: TextEdit = UI_SPLASH.get_node("PopUpContainer/TabContainer/WaitingContainer/TextEdit_WaitingRoom")
@onready var ERROR_CONTAINER: VBoxContainer = UI_SPLASH.get_node("PopUpContainer/TabContainer/ErrorContainer")
@onready var SPRITES_CHARACTER: Node2D = UI_SPLASH.get_node("PopUpContainer/TabContainer/CharacterContainer/VBoxContainer/Selection_Character/SubviewportContainer/SubViewport/Sprites_Character")
@onready var SPRITES_DICTIONARY: Node2D = SPRITES_CHARACTER.get_node("Sprites_Dictionary")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: connect_signals()
#------------------------------------------------------------------------------#
#Custom Functions
#Signal Connections
func connect_signals():
	BUTTON_NEWGAME.connect("server_create", server_create)
	BUTTON_HOSTGAME.connect("server_create", server_create)
	BUTTON_JOINGAME.connect("client_create", client_create)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_successful)
	multiplayer.connection_failed.connect(_on_connection_unsuccessful)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
#Update Dictionary
@rpc("any_peer", "call_local", "reliable")
func update_dictionary():
	var unique_peer = multiplayer.get_unique_id()
	var sprite_paths = SPRITES_DICTIONARY.sprite_paths
	var sprite_info = SPRITES_DICTIONARY.sprite_info
	players[unique_peer] = sprite_paths.merged(sprite_info, true)
	players[unique_peer].set("id", unique_peer)
	var username = players[unique_peer].get("profile")
	players[unique_peer].set("name", username)
#Server Joined
func server_joined(username):
	update_dictionary()
	emit_signal("server_found", username)
	if single_player:
		multiplayer.multiplayer_peer.set_refuse_new_connections(true)
		emit_signal("spawn_requested")
	SPRITES_CHARACTER.server_started = true
#Register Player
@rpc("any_peer", "reliable")
func register_player(new_player_info):
	var joining_player = multiplayer.get_remote_sender_id()
	players[joining_player] = new_player_info
	peer_connected.emit(joining_player, new_player_info)
	players_online += 1
	rpc("update_dictionary")
#Clear Player
@rpc("any_peer", "call_local", "reliable")
func remove_player(id):
	if id != 1: emit_signal("message_leave", id)
	players_online -= 1
	peer_disconnected.emit(id)
	for player in MAIN.ORPHANAGE_PLAYERS.get_children():
		if player.name == str(id): player.queue_free()
	print("Removing Peer [%s] from Game...")
	players.erase(id)
#------------------------------------------------------------------------------#
#Signaled Functions
#Player Connected/Disconnected
func _on_peer_connected(id):
	var sprite_paths = SPRITES_DICTIONARY.sprite_paths
	var sprite_info = SPRITES_DICTIONARY.sprite_info
	print("Peer [%s] Connected!" % id)
	register_player.rpc_id(id, sprite_paths.merged(sprite_info, true))
func _on_peer_disconnected(id):
	print("Peer [%s Disconnected!]" % id)
	rpc("remove_player", id)
#Connection Successful/Unsuccessful
func _on_connection_successful():
	emit_signal("message_join")
	print("Connection Successful!!")
	print("Connected Peers: ", multiplayer.get_peers())
func _on_connection_unsuccessful():
	printerr("Connection Unsuccessful!!")
#Server Disconnected
func _on_server_disconnected():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	players.clear()
	server_disconnected.emit()
	UI_SPLASH.set_deferred("visible", true)
	ERROR_CONTAINER.set_deferred("visible", true)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Create New Server
func server_create(username, _ip):
	if !Engine.has_singleton("Steam"):
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_server(port, max_players)
		if error == OK:
			multiplayer.multiplayer_peer = peer
	server_joined(username)
#Create Client Connection
func client_create(username, ip):
	if !Engine.has_singleton("Steam"):
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_client(ip, port)
		if error == OK:
			multiplayer.multiplayer_peer = peer
	server_joined(username)
