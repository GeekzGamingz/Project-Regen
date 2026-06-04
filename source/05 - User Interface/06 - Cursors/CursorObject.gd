extends Sprite2D

@onready var area_backpack: Area2D = $Area_Backpack

@onready var grid_container: GridContainer = $GridContainer

func check_grid():
	for selection in grid_container.get_children():
		var ray = selection.get_node("RayCast2D")
		if !ray.is_colliding(): selection.visible = false
