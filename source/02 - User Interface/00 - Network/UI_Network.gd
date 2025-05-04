extends VBoxContainer
#------------------------------------------------------------------------------#
#Signals
#signal server_found
signal server_create
signal client_create
#------------------------------------------------------------------------------#
#Variables
#Strings
var username: String
#Exported Variables
@export var port: int = 60005
@export var max_players: int = 4
#OnReady Variables
@onready var line_username: LineEdit = $HBoxContainer/LineEdit_Username
@onready var line_ip: LineEdit = $LineEdit_IPAddress
#------------------------------------------------------------------------------#
#Signaled Functions
#Host Button Up
func _on_button_host_button_up() -> void:
	if line_username.text != "":
		username = line_username.text
		emit_signal("server_create", username)
#Join Button Up
func _on_button_join_button_up() -> void: line_ip.set_deferred("visible", true)
#IP Address Submitted
func _on_ip_text_submitted(new_text: String) -> void:
	if line_username.text != "":
		username = line_username.text
		emit_signal("client_create", username, new_text)
