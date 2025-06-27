extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Booleans
var is_empty: bool = true
#Strings
var contents: String
#Resources
var held_item: Object = null
#OnReady Variables
#Slot Nodes
@onready var texture_object: TextureRect = $Texture_Object
#------------------------------------------------------------------------------#
func _process(_delta: float) -> void:
	if is_empty == true: contents = "Empty"
	else: contents = held_item.name
