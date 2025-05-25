extends Button
#------------------------------------------------------------------------------#
#Signals
signal server_create
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
@onready var splash_screen: Control = $"../../../.."
@onready var tab_container: TabContainer = splash_screen.get_node("PopUpContainer/TabContainer")
@onready var line_username: LineEdit = splash_screen.get_node("PopUpContainer/TabContainer/UsernameContainer/LineEdit_Container/LineEdit_SinglePlayerName")
@onready var button_send_username: Button = splash_screen.get_node("PopUpContainer/TabContainer/UsernameContainer/HBoxContainer/ButtonContainer/Button_SPName")
#------------------------------------------------------------------------------#
#Signaled Functions
#New Game Button Up
func _on_button_up() -> void:
	tab_container.set_deferred("visible", true)
	line_username.set_deferred("visible", true)
	button_send_username.set_deferred("visible", true)
#Username Text Submitted
func _on_line_username_text_submitted(new_text: String) -> void:
	if new_text != "": send_single_player(new_text)
#Send Button Up
func _on_button_send_singleplayer_name_button_up() -> void:
	if line_username.text != "": send_single_player(line_username.text)
#------------------------------------------------------------------------------#
#Custom Functions
#Send Single Player Information
func send_single_player(username):
	if username != "":
		emit_signal("server_create", username, "")
		splash_screen.set_deferred("visible", false)
		NETWORK.single_player = true
	else: emit_signal("error_name")
