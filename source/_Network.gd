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
#Bools
var single_player: bool = false
#Dictionaries
var old_players: Dictionary = {}
var players: Dictionary = {}
@export var player_info: Dictionary = {
	"name": String("Name"),
	"id": String("ID"),
	"position": Vector2.ZERO, #TO DEFINE
	"animation": int(1),
	"height": int(1),
	"chub": bool(false),
	"wheelchair": bool(false),
	"arm_left": int(1),
	"arm_right": int(1),
	"leg_left": int(1), 
	"leg_right": int(1), 
	"ears": int(0),
	"eyeL_color": String("Button_Color1"),
	"eyeR_color": String("Button_Color1"),
	"skin_color": String("Button_Color1"),
	"hair": int(0),
	"hair_color": String("Button_Color1"),
	"bangs": int(0), #TO DEFINE
	"beard": int(0),
	"beard_color": String("Button_Color1")
}
var players_online: int = 1
#Exported Variables
@export var port: int = 60005
@export var max_players: int = 5
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
@onready var UI_SPLASH: Control = MAIN.get_node("UserInterface/UI_FullRect/SplashScreen")
@onready var BUTTON_NEWGAME: Button = UI_SPLASH.get_node("HBoxContainer/SubMenus/SinglePlayer/Button_NewGame")
@onready var BUTTON_HOSTGAME: Button = UI_SPLASH.get_node("HBoxContainer/SubMenus/Multiplayer/Button_HostGame")
@onready var BUTTON_JOINGAME: Button = UI_SPLASH.get_node("HBoxContainer/SubMenus/Multiplayer/Button_JoinGame")
@onready var WAITING_ROOM: TextEdit = UI_SPLASH.get_node("CenterContainer/TabContainer/WaitingContainer/TextEdit_WaitingRoom")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", server_create)
	BUTTON_NEWGAME.connect("server_create", server_create)
	BUTTON_HOSTGAME.connect("server_create", server_create)
	BUTTON_JOINGAME.connect("client_create", client_create)
	UI_NETWORK.connect("client_create", client_create)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_successful)
	multiplayer.connection_failed.connect(_on_connection_unsuccessful)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
#------------------------------------------------------------------------------#
#Custom Functions
func server_joined(username):
	players[multiplayer.get_unique_id()] = player_info
	players[multiplayer.get_unique_id()].set("name", username)
	players[multiplayer.get_unique_id()].set("id", multiplayer.get_unique_id())
	peer_connected.emit(multiplayer.get_unique_id(), player_info)
	emit_signal("server_found", username)
	UI_NETWORK.get_node("VBoxContainer/LineEdit_IPAddress").set_deferred("visible", false)
	UI_NETWORK.get_node("VBoxContainer/UI_Connections").set_deferred("visible", false)
	if single_player:
		multiplayer.multiplayer_peer.set_refuse_new_connections(true)
		emit_signal("spawn_requested")
#Register Player
@rpc("any_peer", "reliable")
func register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	peer_connected.emit(new_player_id, new_player_info)
	rpc_id(new_player_id, "player_update", +1)
#Update Players Online
@rpc("any_peer", "call_local")
func player_update(value): players_online += value
#------------------------------------------------------------------------------#
#Signaled Functions
#Player Connected/Disconnected
func _on_peer_connected(id): register_player.rpc_id(id, player_info)
func _on_peer_disconnected(id):
	emit_signal("message_leave", id)
	rpc("player_update", -1)
	players.erase(id)
	peer_disconnected.emit(id)
#Connection Successful/Unsuccessful
func _on_connection_successful(): emit_signal("message_join")
func _on_connection_unsuccessful(): multiplayer.multiplayer_peer = null
#Server Disconnected
func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()
	get_tree().quit() #Temp Failsafe
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Create New Server
func server_create(username, _ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, max_players)
	multiplayer.multiplayer_peer = peer
	server_joined(username)
#Create Client Connection
func client_create(username, ip):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	server_joined(username)
	
