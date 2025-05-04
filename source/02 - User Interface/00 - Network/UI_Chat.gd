extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
var chatter: String
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
@onready var text_messages: TextEdit = $HBoxContainer/VBoxContainer/Text_Messages
@onready var line_message: LineEdit = $HBoxContainer/VBoxContainer/HBoxContainer2/LineEdit_Message
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: NETWORK.connect("server_found", server_found)
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
		message_rpc.rpc(chatter, line_message.text)
		line_message.text = ""
#------------------------------------------------------------------------------#
#Custom Signaled Function
func server_found(username): chatter = username
#------------------------------------------------------------------------------#
#RPC Functions
@rpc("any_peer", "call_local")
func message_rpc(username, message):
	text_messages.text += str(username, ": ", message,"\n")
	text_messages.scroll_vertical = text_messages.get_line_height()
