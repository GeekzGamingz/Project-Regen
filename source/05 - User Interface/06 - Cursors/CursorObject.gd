extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var area_containers: Area2D = $Area_Containers
@onready var area_poly: CollisionPolygon2D = $Area_Containers/CollisionPolygon2D
@onready var grid_container: GridContainer = $GridContainer
#------------------------------------------------------------------------------#
#Functions
#Custom Functions
func shape_grid():
	area_poly.disabled = false #Reset Polygon
	await get_tree().process_frame
	for selection in grid_container.get_children():
		var ray = selection.get_node("RayCast2D")
		ray.enabled = true #Reset RayCast2D
		ray.force_raycast_update()
		#Set Self-Modulation Not Visibility Due to Grid Container
		if !ray.is_colliding():
			selection.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
			ray.set_deferred("enabled", false)
		else: selection.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	area_poly.set_deferred("disabled", true)
