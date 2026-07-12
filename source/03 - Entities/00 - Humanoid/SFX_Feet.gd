extends AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Constants
const FOOTSTEPS_DIRT_STONE = preload("res://assets/06 - SFX/Footsteps Dirt Stone.ogg")
const FOOTSTEPS_GRASS = preload("res://assets/06 - SFX/Footsteps Grass.ogg")
#------------------------------------------------------------------------------#
#Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var e: Entity = $"../.."
#------------------------------------------------------------------------------#
#Functions
#Custom Functions
func footstep():
	var grass_cell = MAIN.MAP_GRASS.local_to_map(e.global_position) #Finds Grass Cell
	var regen_tree = MAIN.ORPHANAGE_FLORA.get_node("Flora_RegenTree")
	if regen_tree.grass_array.has(grass_cell): set_stream(FOOTSTEPS_GRASS)
	else: set_stream(FOOTSTEPS_DIRT_STONE)
	play()
