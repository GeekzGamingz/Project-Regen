extends Entity
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var HOTBAR: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Hotbar")
#Local Nodes
@onready var player_serverinfo: Node2D = $Scripts/Player_ServerInfo
@onready var output_name: Label = $Outputs/Output_Name
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction: Node2D = $Scripts/Player_Interaction
@onready var marker_drop: Marker2D = $Marker_Drop
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: HOTBAR.set_deferred("visible", true)
#------------------------------------------------------------------------------#
#Signaled Functions
#On Tree Entered
func _on_tree_entered() -> void: set_multiplayer_authority(name.to_int())
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_name(username, _new_text):
	output_name.text = username
	output_name.set_deferred("visible", true)
