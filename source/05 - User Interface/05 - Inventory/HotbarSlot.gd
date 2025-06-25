extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Booleans
var is_empty: bool = true
#Strings
var contents: String
#------------------------------------------------------------------------------#
func _process(_delta: float) -> void:
	if is_empty == true: contents = "Empty"
