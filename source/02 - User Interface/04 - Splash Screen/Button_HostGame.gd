extends Button
#------------------------------------------------------------------------------#
#Signals
signal server_create
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var splash_screen: Control = $"../../../.."
#Tabs
#Username Container
@onready var tab_container: TabContainer = splash_screen.get_node("CenterContainer/TabContainer")
@onready var line_username: LineEdit = splash_screen.get_node("CenterContainer/TabContainer/UsernameContainer/LineEdit_Container/LineEdit_HostName")
@onready var button_send_username: Button = splash_screen.get_node("CenterContainer/TabContainer/UsernameContainer/HBoxContainer/ButtonContainer/Button_HostName")
#Waiting Container
@onready var waiting_container: VBoxContainer = splash_screen.get_node("CenterContainer/TabContainer/WaitingContainer")
#------------------------------------------------------------------------------#
#Signaled Functions
#Host Game Button Up
func _on_button_up() -> void:
	tab_container.set_deferred("visible", true)
	line_username.set_deferred("visible", true)
	button_send_username.set_deferred("visible", true)
#Username Text Submitted
func _on_line_username_text_submitted(new_text: String) -> void:
	if new_text != "": send_host(new_text)
#Send Button Up
func _on_button_send_host_name_button_up() -> void:
	if line_username.text != "": send_host(line_username.text)
#------------------------------------------------------------------------------#
#Custom Functions
#Send Host Information
func send_host(username):
	if username != "":
		waiting_container.set_deferred("visible", true)
		emit_signal("server_create", username, "")
		#splash_screen.set_deferred("visible", false)
	else: emit_signal("error_name")
