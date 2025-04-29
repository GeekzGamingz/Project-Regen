extends StaticBody2D
#------------------------------------------------------------------------------#
#Variables
#Nodes
var map_world: TileMapLayer
var map_grass: TileMapLayer
#Vectors
var start_tile: Vector2i
#Arrays
var grass_array: Array = []
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
					spawn_grass_initial()
					print("[!Regen Activated!]")
#Signaled Functions
func _on_timer_growth_timeout() -> void: spawn_grass()
#------------------------------------------------------------------------------#
#Custom Functions
func spawn_grass_initial():
	var regen_tile = Vector2i(global_position)
	#World Tilemap Layer
	map_world = MAIN.MAP_WORLD
	var world_offset = Vector2i($CollisionShape2D.position) / Vector2i(G.TILE_SIZE)
	var world_position = map_world.local_to_map(regen_tile) + world_offset
	var world_data = map_world.get_cell_tile_data(world_position)
	#Grass Tilemap Layer
	map_grass = MAIN.MAP_GRASS
	var grass_offset = Vector2i($CollisionShape2D.position) / Vector2i(G.GRASS_SIZE)
	var grass_position = map_grass.local_to_map(regen_tile) + grass_offset
	#Check for Water
	if !world_data.get_custom_data("Water"):
		map_grass.set_cell(grass_position, 0, Vector2i(3, 3), false)
		grass_array.append(grass_position)
		start_tile = grass_position
		timer_growth.start()
		#var grass_neighbors = map_grass.get_surrounding_cells(grass_position + regen_offset)
		#grass_array.append_array(grass_neighbors)
		#print(grass_array)
		#map_grass.set_cells_terrain_connect(grass_array, 0, 0, true)
func spawn_grass():
	randomize()
	var neighbor_random = (randi() % 4)
	match(neighbor_random):
		0: neighbor_random = TileSet.CELL_NEIGHBOR_LEFT_SIDE
		1: neighbor_random = TileSet.CELL_NEIGHBOR_RIGHT_SIDE
		2: neighbor_random = TileSet.CELL_NEIGHBOR_TOP_SIDE
		3: neighbor_random = TileSet.CELL_NEIGHBOR_BOTTOM_SIDE
	print("Starting Growth Tile: ", start_tile)
	var neighbor = map_grass.get_neighbor_cell(start_tile, neighbor_random)
	grass_array.append(neighbor)
	#if is not equal to get_used_cells
	map_grass.set_cells_terrain_connect(grass_array, 0, 0, true)
	start_tile = neighbor #CHANGE TO RANDOM IN GRASS ARRAY
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
