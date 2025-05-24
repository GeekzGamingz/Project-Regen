extends Control
#------------------------------------------------------------------------------#
#Variables
#Strings
var connected_peer: String
#OnReady Variabels
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
@onready var line_waiting_room: LineEdit = $CenterContainer/TabContainer/WaitingContainer/LineEdit_WaitingRoom
#Tabs
@onready var sub_menus: TabContainer = $HBoxContainer/SubMenus
@onready var tab_singleplayer: VBoxContainer = $HBoxContainer/SubMenus/SinglePlayer
@onready var tab_multiplayer: VBoxContainer = $HBoxContainer/SubMenus/Multiplayer
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	NETWORK.connect("message_join", message_join)
	NETWORK.connect("server_found", server_found)
#------------------------------------------------------------------------------#
#Signaled Functions
#Single Player
func _on_button_single_player_button_up() -> void:
	sub_menus.set_deferred("visible", true)
	tab_singleplayer.set_deferred("visible", true)
	NETWORK.single_player = true
#Multiplayer
func _on_button_multiplayer_button_up() -> void:
	sub_menus.set_deferred("visible", true)
	tab_multiplayer.set_deferred("visible", true)
	NETWORK.single_player = false
#Quit
func _on_button_quit_button_up() -> void: get_tree().quit()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Waiting Room
@rpc("any_peer", "call_local")
func update_waiting_room(username): line_waiting_room.text += str("[", username, "] has joined!")
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func server_found(username): connected_peer = username
func message_join(): rpc("update_waiting_room", connected_peer)
