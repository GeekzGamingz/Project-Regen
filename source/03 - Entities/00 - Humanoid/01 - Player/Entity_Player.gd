extends Entity
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var COLOR_SELECT: TabContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Customization/VBoxContainer/Selection_Color")
#Local Nodes
@onready var output_name: Label = $Outputs/Output_Name
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", update_name)
	UI_NETWORK.connect("client_create", update_name)
#------------------------------------------------------------------------------#
#Signaled Functions
#On Tree Entered
func _on_tree_entered() -> void:
	set_multiplayer_authority(name.to_int())
	start_color()
#------------------------------------------------------------------------------#
#Custom Functions
func start_color() -> void:
	await get_tree().create_timer(0.01).timeout
	COLOR_SELECT.random_color("Skin")
	COLOR_SELECT.random_color("Hair")
	COLOR_SELECT.random_color("Beard")
	COLOR_SELECT.random_color("EyeL")
	COLOR_SELECT.random_color("EyeR")
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_name(username, _new_text):
	output_name.text = username
	output_name.set_deferred("visible", true)


	
