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
@onready var text_waiting_room: TextEdit = $PopUpContainer/TabContainer/WaitingContainer/TextEdit_WaitingRoom
#Tabs
@onready var sub_menus: TabContainer = $HBoxContainer/SubMenus
@onready var tab_singleplayer: VBoxContainer = $HBoxContainer/SubMenus/SinglePlayer
@onready var tab_multiplayer: VBoxContainer = $HBoxContainer/SubMenus/Multiplayer
@onready var error_container: VBoxContainer = $PopUpContainer/TabContainer/ErrorContainer
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	NETWORK.connect("message_join", message_join)
	NETWORK.connect("server_found", server_found)
	multiplayer.connection_failed.connect(message_error)
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
func update_waiting_room(username): text_waiting_room.text += str("\n[", username, "] has joined!")
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func server_found(username): connected_peer = username
func message_join(): rpc("update_waiting_room", connected_peer)
func message_error():
	print("Connection Failed")
	error_container.set_deferred("visible", true)
