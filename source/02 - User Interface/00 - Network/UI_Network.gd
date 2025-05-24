extends HBoxContainer
#------------------------------------------------------------------------------#
#Signals
#signal server_found
signal server_create
signal client_create
signal error_name
signal error_select_connection
#------------------------------------------------------------------------------#
#Variables
#Strings
var username: String
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var line_username: LineEdit = $VBoxContainer/UI_Connections/LineEdit_Username
@onready var line_ip: LineEdit = $VBoxContainer/LineEdit_IPAddress
#@onready var button_spawn: TextureButton = $"../CenterContainer/Button_Spawn"
#------------------------------------------------------------------------------#
#Signaled Functions
#Host Button Up
func _on_button_host_button_up() -> void:
	if line_username.text != "":
		username = line_username.text
		emit_signal("server_create", username, "")
		#button_spawn.set_deferred("visible", true)
	else: emit_signal("error_name")
#Join Button Up
func _on_button_join_button_up() -> void:
	if line_username.text != "": line_ip.set_deferred("visible", true)
	else: emit_signal("error_name")
#Name Submitted
func _on_line_username_text_submitted(new_text: String) -> void:
	if new_text != "": emit_signal("error_select_connection")
#IP Address Submitted
func _on_ip_text_submitted(new_text: String) -> void:
	if line_username.text != "":
		username = line_username.text
		emit_signal("client_create", username, new_text)
