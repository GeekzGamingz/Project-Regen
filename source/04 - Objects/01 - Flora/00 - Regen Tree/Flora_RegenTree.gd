extends Interactable
#------------------------------------------------------------------------------#
#Variables
#Nodes
var timer_ticks: Timer
var map_world: TileMapLayer
var map_grass: TileMapLayer
#Vectors
var start_tile: Vector2i
#Arrays
var grass_array: Array = []
var water_array: Array = []
#Exported Variables
@export var is_active: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var timer_growth: Timer = $Timers/Timer_Growth
#Offsets
@onready var world_offset = Vector2i($CollisionShape2D.position) / Vector2i(G.TILE_SIZE)
@onready var grass_offset = Vector2i($CollisionShape2D.position) / Vector2i(G.GRASS_SIZE)
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_timer_growth_timeout() -> void:
	if grass_array.size() < 420: spawn_grass() #Size to Change as Regen Tree Grows
#------------------------------------------------------------------------------#
#Custom Functions
func activate():
	if !is_active:
		is_active = true
		MAIN.TIME.connect("tick_elapsed", tick_elapsed)
		spawn_grass_initial()
#Spawn Initial Grass
func spawn_grass_initial():
	var regen_tile = Vector2i(global_position)
	#World Tilemap Layer
	map_world = MAIN.MAP_WORLD
	var world_position = map_world.local_to_map(regen_tile) + world_offset
	var world_data = map_world.get_cell_tile_data(world_position)
	#Grass Tilemap Layer
	map_grass = MAIN.MAP_GRASS
	var grass_position = map_grass.local_to_map(regen_tile) + grass_offset
	#Check for Water
	if !world_data.get_custom_data("Water"):
		map_grass.set_cell(grass_position, 0, Vector2i(3, 3), false)
		grass_array.append(grass_position)
		start_tile = grass_position
		timer_growth.start()
	#Get Time
	timer_ticks = MAIN.TIME.get_node("Timer_Ticks")
#Spawn Grass
func spawn_grass():
	randomize()
	var random_tile = grass_array.pick_random()
	var tile_position = map_grass.to_global(random_tile) * Vector2(G.GRASS_SIZE)
	var world_position = map_world.local_to_map(tile_position)
	var world_data = map_world.get_cell_tile_data(world_position)
	if !world_data.get_custom_data("Water"):
		for cell in map_grass.get_surrounding_cells(random_tile):
			if map_grass.get_cell_atlas_coords(cell) != Vector2i(-1, -1):
				timer_growth.wait_time = timer_ticks.wait_time
				timer_growth.start()
			else:
				var temp_array = [random_tile, cell]
				grass_array.append(cell)
				map_grass.set_cells_terrain_connect(temp_array, 0, 0, true)
				timer_growth.wait_time = timer_ticks.wait_time
				break
	else:
		water_array.append(random_tile)
		grass_array.erase(random_tile)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Tick Elapsed
func tick_elapsed(_ticks):
	if timer_growth.is_stopped():
		randomize()
		var time_random = randf_range(timer_growth.wait_time, timer_growth.wait_time * 2.5)
		timer_growth.wait_time = time_random
		timer_growth.start()
	else: map_grass.set_cells_terrain_connect(water_array, 0, -1, true)
