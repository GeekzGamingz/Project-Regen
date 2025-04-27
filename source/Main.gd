extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Scenes
#User Interface
@onready var UI: CanvasLayer = $UserInterface
@onready var MENU_TOOLS: HBoxContainer = $UserInterface/UI_FullRect/Menu_Tools
@onready var MENU_BUILDINGS: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Build/Menu_Buildings
@onready var MENU_FLORA: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Sow/Menu_Flora
#Building Grid
@onready var BUILD_GRID: TileMapLayer = $BuildingGrid
@onready var BLUEPRINT: Control = $BuildingGrid/Blueprint_Control
#Camera
@onready var CAMERA_MAIN: Camera2D = $Camera_Main
#Calendar
@onready var CALENDAR: Node2D = $Calendar
#Orphanages
@onready var ORPHANAGES: Node2D = $Orphanages
@onready var ORPHANAGE_BUILDINGS: Node2D = $Orphanages/Orphanage_Buildings
@onready var ORPHANAGE_FLORA: Node2D = $Orphanages/Orphanage_Flora
@onready var ORPHANAGE_ENTITES: Node2D = $Orphanages/Orphanage_Entities
