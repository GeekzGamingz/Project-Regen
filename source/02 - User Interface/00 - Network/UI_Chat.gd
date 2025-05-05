extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
var chatter: String
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Local Nodes
@onready var text_messages: TextEdit = $HBoxContainer/VBoxContainer/Text_Messages
@onready var line_message: LineEdit = $HBoxContainer/VBoxContainer/HBoxContainer2/LineEdit_Message
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	NETWORK.connect("server_found", server_found)
	NETWORK.connect("message_join", message_join)
	UI_NETWORK.connect("error_name", error_name)
	UI_NETWORK.connect("error_select_connection", error_select_connection)
#------------------------------------------------------------------------------#
#Signaled Functions
#Send Message with Send
func _on_button_send_button_up() -> void: send_message()
#Send Message with Enter
func _on_line_message_text_submitted(_new_text: String) -> void: send_message()
#------------------------------------------------------------------------------#
#Custom Functions
func send_message():
	if line_message.text != "":
		if chatter != "": rpc("message_rpc", chatter, line_message.text)
		else: error_name()
		line_message.text = ""
#------------------------------------------------------------------------------#
#Custom Signaled Function
func server_found(username): chatter = username
#Chat Prompts
func message_join(): rpc("message_rpc", "Narrating Voice", str(chatter, " has arrived!"))
#Error Messages
func error_name(): message_rpc("Narrating Voice", str(chatter, " What should we call you...?"))
func error_select_connection(): message_rpc("Narrating Voice", "Will you be Hosting or Joining a Server?")
#------------------------------------------------------------------------------#
#RPC Functions
@rpc("any_peer", "call_local")
func message_rpc(username, message):
	text_messages.text += str(username, ": ", message,"\n")
	text_messages.scroll_vertical = text_messages.get_line_height()
