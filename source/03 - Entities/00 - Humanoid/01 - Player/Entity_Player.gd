extends Entity
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var output_name: Label = $Outputs/Output_Name
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	UI_NETWORK.connect("server_create", update_name)
	UI_NETWORK.connect("client_create", update_name)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_name(username, _new_text):
	output_name.text = username
	output_name.set_deferred("visible", true)


func _on_tree_entered() -> void: print(is_multiplayer_authority())
