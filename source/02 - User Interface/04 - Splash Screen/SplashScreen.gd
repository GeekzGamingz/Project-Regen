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
@onready var customization: Control = $"../UI_Customization"
@onready var text_waiting_room: TextEdit = $PopUpContainer/TabContainer/WaitingContainer/TextEdit_WaitingRoom
@onready var sprites_colors: Node2D = $PopUpContainer/TabContainer/CharacterContainer/VBoxContainer/Selection_Character/SubviewportContainer/SubViewport/Sprites_Character/Sprites_Colors
#Tabs
@onready var sub_menus: TabContainer = $HBoxContainer/SubMenus
@onready var tab_singleplayer: VBoxContainer = $HBoxContainer/SubMenus/SinglePlayer
@onready var tab_multiplayer: VBoxContainer = $HBoxContainer/SubMenus/Multiplayer
@onready var tab_container: TabContainer = $PopUpContainer/TabContainer
@onready var error_container: VBoxContainer = $PopUpContainer/TabContainer/ErrorContainer
@onready var character_container: CenterContainer = $PopUpContainer/TabContainer/CharacterContainer
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
	visibility_reset()
	sub_menus.set_deferred("visible", true)
	tab_singleplayer.set_deferred("visible", true)
	NETWORK.single_player = true
#Multiplayer
func _on_button_multiplayer_button_up() -> void:
	visibility_reset()
	sub_menus.set_deferred("visible", true)
	tab_multiplayer.set_deferred("visible", true)
	NETWORK.single_player = false
#Character
func _on_button_character_button_up() -> void:
	visibility_reset()
	tab_container.set_deferred("visible", true)
	character_container.set_deferred("visible", true)
	customization.set_deferred("visible", true)
	sprites_colors.check_colors()
#Quit
func _on_button_quit_button_up() -> void: get_tree().quit()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Waiting Room
@rpc("any_peer", "call_local")
func update_waiting_room(username): text_waiting_room.text += str("\n[", username, "] has joined!")
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Retrieving Username
func server_found(username): connected_peer = username
#Update List
func message_join(): rpc("update_waiting_room", connected_peer)
#Error Timeout
func message_error(): error_container.set_deferred("visible", true)
#Visibility Toggle
func visibility_reset():
	sub_menus.set_deferred("visible", false)
	tab_container.set_deferred("visible", false)
	customization.set_deferred("visible", false)
