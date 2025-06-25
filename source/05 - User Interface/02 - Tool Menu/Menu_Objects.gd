extends VBoxContainer
#------------------------------------------------------------------------------#
signal change_selection
#------------------------------------------------------------------------------#
#Variables
#Strings
var object: PackedScene
#Exported Variables
@export var objects: Array[PackedScene]
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	check_objects()
#------------------------------------------------------------------------------#
#Custom Functions
#Check for Unlocked Buildings
func check_objects() -> void:
	for o in objects:
		var object_icon = o.instantiate()
		if object_icon.is_unlocked:
			object_icon.set_deferred("visible", true)
			add_child(object_icon)
			object_icon.connect("send_dimensions", send_dimensions)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func send_dimensions(dimensions): emit_signal("change_selection", dimensions)
