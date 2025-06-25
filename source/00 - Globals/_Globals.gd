extends Node
#------------------------------------------------------------------------------#
#Global Constants
const PATH_PROFILES = "user://save_profiles.json"
#------------------------------------------------------------------------------#
#Global Variables
#Integers
var CURRENT_TICK: int = 0
#Vectors
var TILE_SIZE: Vector2i = Vector2(16, 16)
var GRASS_SIZE: Vector2i = Vector2(8, 8)
#Global Booleans Variables
var IS_BUILDING: bool = false
var CAN_BUILD: bool = false
#------------------------------------------------------------------------------#
#Global Functions
#Save File
func SAVE(path: String, contents):
	var json_string = JSON.stringify(contents)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_line(json_string)
#Load File
func LOAD(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	var file_string = file.get_as_text()
	var contents = JSON.parse_string(file_string)
	return contents
