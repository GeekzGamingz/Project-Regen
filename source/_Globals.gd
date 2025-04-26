extends Node
#------------------------------------------------------------------------------#
#Global Variables
var TILE_SIZE: Vector2 = Vector2(16, 16)
#Global Bool Variables
var IS_BUILDING: bool = false
var CAN_BUILD: bool = false
#Global Dictionaries
var ZONE_TEXTURES: Dictionary = {
	"ZONE_16x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16.png"),
	"ZONE_16x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x32.png"),
	"ZONE_16x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x48.png"),
	"ZONE_16x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x64.png"),
	"ZONE_32x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32.png"),
	"ZONE_32x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x16.png"),
	"ZONE_32x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x48.png"),
	"ZONE_32x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x64.png"),
	"ZONE_48x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48.png"),
	"ZONE_48x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x16.png"),
	"ZONE_48x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x32.png"),
	"ZONE_48x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x64.png"),
	"ZONE_64x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x16.png"),
	"ZONE_64x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x32.png"),
	"ZONE_64x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x48.png"),
	"ZONE_64x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64.png")
}
#------------------------------------------------------------------------------#
