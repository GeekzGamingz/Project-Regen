extends Button
#------------------------------------------------------------------------------#
#Signals
signal client_create
#------------------------------------------------------------------------------#
#Variables
var client_username
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
@onready var splash_screen: Control = $"../../../.."
@onready var tab_container: TabContainer = splash_screen.get_node("CenterContainer/TabContainer")
@onready var line_username: LineEdit = splash_screen.get_node("CenterContainer/TabContainer/UsernameContainer/LineEdit_Container/LineEdit_ClientName")
@onready var button_send_username: Button = splash_screen.get_node("CenterContainer/TabContainer/UsernameContainer/HBoxContainer/ButtonContainer/Button_ClientName")
@onready var ip_address_container: VBoxContainer = splash_screen.get_node("CenterContainer/TabContainer/IPAddressContainer")
@onready var line_ip_address: LineEdit = splash_screen.get_node("CenterContainer/TabContainer/IPAddressContainer/LineEdit_IPAddress")
@onready var button_ip_address: Button = splash_screen.get_node("CenterContainer/TabContainer/IPAddressContainer/HBoxContainer/Button_IPAddress")
#------------------------------------------------------------------------------#
#Signaled Functions
#Join Game Button Up
func _on_button_up() -> void:
	tab_container.set_deferred("visible", true)
	line_username.set_deferred("visible", true)
	button_send_username.set_deferred("visible", true)
#Username Text Submitted
func _on_line_username_text_submitted(new_text: String) -> void:
	if new_text != "":
		client_username = new_text
		ip_address_container.set_deferred("visible", true)
#Send Button Up
func _on_button_send_client_name_button_up() -> void:
	if line_username.text != "":
		client_username = line_username.text
		ip_address_container.set_deferred("visible", true)
	#if line_username.text != "": send_client(line_username.text, ip)
#IP Address Text Submitted
func _on_line_edit_ip_address_text_submitted(new_text: String) -> void:
	if line_ip_address.text != "": send_client(client_username, new_text)
#IP Address Button Up
func _on_button_ip_address_button_up() -> void:
	if line_ip_address.text != "": send_client(client_username, line_ip_address.text)
#------------------------------------------------------------------------------#
#Custom Functions
#Send Client Information
func send_client(username, ip):
	splash_screen.set_deferred("visible", false)
	emit_signal("client_create", client_username, ip)
