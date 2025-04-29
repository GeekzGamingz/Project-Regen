extends StaticBody2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var is_active: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var ray_pdetect: Node2D = $Raycasts/Ray_PlayerDetection
@onready var timer_growth: Timer = $Timers/Timer_Growth
#------------------------------------------------------------------------------#
	#var mouse_tile = get_global_mouse_position() #Position of Mouse
	#var map_position = local_to_map(mouse_tile) #Convert to Map
	#var cell_position = map_to_local(map_position) #Convert to Local Coordinates
	#BLUEPRINT.position = to_global(cell_position) - (G.TILE_SIZE * 0.5)
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_interact"):
		if is_active: print("[!Already Active!]")
		for ray in ray_pdetect.get_children():
			if ray.is_colliding():
				if !is_active:
					is_active = true
					MAIN.CALENDAR.connect("tick_elapsed", tick_elapsed)
					print("[!Regen Activated!]")
#Signaled Functions
func _on_timer_growth_timeout() -> void:
	var map_world = MAIN.MAP_WORLD
	var map_grass = MAIN.MAP_GRASS
	var regen_tile = global_position
	
	var world_position = map_world.local_to_map(regen_tile)
	var world_cell = map_world.map_to_local(world_position)
	var world_source = map_world.get_cell_source_id(world_position)
	var world_data = map_world.get_cell_tile_data(world_position)
	var world_tileset = map_world.tile_set
	var world_neighbor = map_world.get_neighbor_cell(world_position, 0)
	var world_neighbors = map_world.get_surrounding_cells(world_position)
	var grass_position = map_grass.local_to_map(regen_tile)
	var grass_neighbors = map_grass.get_surrounding_cells(world_position)
	print("+-TILESET: ", world_tileset)
	print("World Tile Data: ", world_data.get_custom_data("Water"))
	print("World Tile Position: ", world_cell)
	print("World Tile Source ID: ", world_source)
	print("World Tile Right Neighbor: ", world_neighbor)
	print("World Tile Neighbor Array: ", world_neighbors)
	print("Grass Tile Neighbor Array: ", grass_neighbors)
	if !world_data.get_custom_data("Water"):
		var regen_offset: Vector2i = Vector2i($CollisionShape2D.position) / Vector2i(G.GRASS_SIZE)
		map_grass.set_cell(grass_position + regen_offset, 0, Vector2i(3, 3))
		map_grass.set_cells_terrain_connect(map_grass.get_surrounding_cells(grass_position + regen_offset), 0, 0, true)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func tick_elapsed(ticks):
	print("+---!Tick!---+")
	print("Ticks: ", ticks)
	if timer_growth.is_stopped():
		randomize()
		var time_random = randf_range(1, 5)
		timer_growth.wait_time = time_random
		timer_growth.start()
