extends StaticBody2D
#------------------------------------------------------------------------------#
#Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var TIME: Node2D = MAIN.get_node("World/Time")
#Sprites
@onready var sprite_object: Sprite2D = $Sprites/Sprite_Object
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	#Connections
	TIME.connect("month_elapsed", month_elapsed)
	TIME.connect("season_elapsed", season_elapsed)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Month Elapsed
func month_elapsed(month):
	if sprite_object.frame_coords.x < 4: sprite_object.frame_coords.x += 1
	print("[!Month Elapsed!] Current Month: ", month)
#Season Elapsed
func season_elapsed(season):
	match(season):
		"Sowing", "Rest": sprite_object.frame_coords.y = 1
		"Growth", "Tending": sprite_object.frame_coords.y = 2
		"Harvest": sprite_object.frame_coords.y = 3
	print("[!Season Elapsed!] Current Season: ", season)
