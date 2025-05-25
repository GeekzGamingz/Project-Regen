extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
var chatter: String
var commands: Array = [
	"/help",
	"/players",
	"/playerids",
	"/playerinfo"
]
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Local Nodes
@onready var text_messages: TextEdit = $HBoxContainer/VBoxContainer/Text_Messages
@onready var line_message: LineEdit = $HBoxContainer/VBoxContainer/HBoxContainer2/LineEdit_Message
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	NETWORK.connect("server_found", server_found)
	NETWORK.connect("message_join", message_join)
	NETWORK.connect("message_leave", message_leave)
#------------------------------------------------------------------------------#
#Signaled Functions
#Send Message with Send
func _on_button_send_button_up() -> void: send_message()
#Send Message with Enter
func _on_line_message_text_submitted(_new_text: String) -> void: send_message()
#------------------------------------------------------------------------------#
#Custom Functions
#Send Message
func send_message():
	var command_sent = commands.has(line_message.text)
	if line_message.text != "" && !command_sent:
		if chatter != "": rpc("message_add", chatter, line_message.text)
	chat_commands()
	line_message.text = ""
	text_messages.scroll_vertical = text_messages.get_line_height()
#Chat Commands
func chat_commands():
	if line_message.text == "":
		text_messages.text += str("Type \"/help\" for a List of Commands...\n")
	elif line_message.text == "/help":
		text_messages.text += str(
			"List of Commands:\n",
			"/players [List Current Active Players]\n",
			"/playerids [List Current Player IDs]\n",
			"/playerinfo [List Player Information Dictionary]\n"
			)
	elif line_message.text == "/players":
		text_messages.text += str("There are [", NETWORK.players_online, "] Players Online: ")
		for player in NETWORK.players.values():
			text_messages.text += str("[", player["name"], "] ")
		text_messages.text += str("\n")
	elif line_message.text == "/playerids":
		text_messages.text += str("Player Unique IDs:\n")
		text_messages.text += str("#----------#\n")
		for player in NETWORK.players.values():
			text_messages.text += str("[", player["name"], "] - ")
			text_messages.text += str(player["id"], "\n")
		text_messages.text += str("#----------#\n")
	elif line_message.text == "/playerinfo":
		text_messages.text += str("Player Information Dictionary:\n")
		text_messages.text += str("#----------#\n")
		text_messages.text += str(NETWORK.players)
		text_messages.text += str("\n#----------#\n")
	text_messages.scroll_vertical = text_messages.get_line_height()
#------------------------------------------------------------------------------#
#Custom Signaled Function
func server_found(username): chatter = username
#Chat Prompts
func message_join(): rpc("message_add", "Narrating Voice", str(chatter, " has arrived!"))
func message_leave(id): rpc_id(
	multiplayer.get_unique_id(),
	"message_add", "Narrating Voice", str(NETWORK.players[id].get("name"), " has left!")
	)
#------------------------------------------------------------------------------#
#RPC Functions
@rpc("any_peer", "call_local")
func message_add(username, message):
	text_messages.text += str(username, ": ", message,"\n")
	text_messages.scroll_vertical = text_messages.get_line_height()
