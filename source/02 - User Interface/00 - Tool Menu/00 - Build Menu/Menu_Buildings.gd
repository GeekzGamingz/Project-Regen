extends VBoxContainer
#------------------------------------------------------------------------------#
signal change_selection
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var buildings: Array[PackedScene]
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	check_buildings()
#------------------------------------------------------------------------------#
#Custom Functions
#Check for Unlocked Buildings
func check_buildings() -> void:
	for b in buildings:
		var building_icon = b.instantiate()
		if building_icon.is_unlocked:
			building_icon.set_deferred("visible", true)
			add_child(building_icon)
			building_icon.connect("send_dimensions", send_dimensions)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func send_dimensions(dimensions): emit_signal("change_selection", dimensions)
