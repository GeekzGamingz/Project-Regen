extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Scenes
#User Interface
@onready var UI: CanvasLayer = $UserInterface
@onready var MENU_TOOLS: HBoxContainer = $UserInterface/UI_FullRect/Menu_Tools
@onready var MENU_BUILDINGS: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/Menu_Buildings
#Building Grid
@onready var BUILD_GRID: TileMapLayer = $BuildingGrid
@onready var BLUEPRINT: Control = $BuildingGrid/Blueprint_Control
#Camera
@onready var CAMERA_MAIN: Camera2D = $Camera_Main
#Orphanages
@onready var ORPHANAGE_BUILDINGS: Node2D = $Orphanage_Buildings
@onready var ORPHANAGE_OBJECTS: Node2D = $Orphanage_Objects
@onready var ORPHANAGE_ENTITES: Node2D = $Orphanage_Entities
