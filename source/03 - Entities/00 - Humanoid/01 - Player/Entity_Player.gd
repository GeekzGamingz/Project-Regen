extends Entity
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var output_name: Label = $Outputs/Output_Name
#Main Nodes
@onready var UI_NETWORK: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", update_name)
	UI_NETWORK.connect("client_create", update_name)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_name(username):
	output_name.text = username
	output_name.set_deferred("visible", true)
