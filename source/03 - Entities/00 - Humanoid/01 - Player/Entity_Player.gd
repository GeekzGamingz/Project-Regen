extends Entity
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var player_serverinfo: Node2D = $Scripts/Player_ServerInfo
@onready var output_name: Label = $Outputs/Output_Name
#------------------------------------------------------------------------------#
#Signaled Functions
#On Tree Entered
func _on_tree_entered() -> void: set_multiplayer_authority(name.to_int())
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_name(username, _new_text):
	output_name.text = username
	output_name.set_deferred("visible", true)
