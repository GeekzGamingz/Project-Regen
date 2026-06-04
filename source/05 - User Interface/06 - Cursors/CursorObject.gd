extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var area_backpack: Area2D = $Area_Backpack
@onready var grid_container: GridContainer = $GridContainer
#------------------------------------------------------------------------------#
#Functions
#Custom Functions
func check_grid():
	await get_tree().process_frame
	for selection in grid_container.get_children():
		var ray = selection.get_node("RayCast2D")
		ray.force_raycast_update()
		#Set Modulation Not Visibility Due to Grid Container
		if !ray.is_colliding(): selection.modulate = Color(1.0, 1.0, 1.0, 0.0)
		else: selection.modulate = Color(1.0, 1.0, 1.0)
