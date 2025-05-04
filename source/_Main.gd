extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Scenes
#User Interface
@onready var UI: CanvasLayer = $UserInterface
@onready var UI_NETWORK: VBoxContainer = $UserInterface/UI_FullRect/UI_Network
@onready var UI_CHAT: VBoxContainer = $UserInterface/UI_FullRect/UI_Chat
@onready var MENU_TOOLS: HBoxContainer = $UserInterface/UI_FullRect/Menu_Tools
@onready var MENU_BUILDINGS: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Build/Menu_Buildings
@onready var MENU_FLORA: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Sow/Menu_Flora
#Tile Sets
@onready var MAP_WORLD: TileMapLayer = $World/Mapping/Map_World
@onready var MAP_GRASS: TileMapLayer = $World/Mapping/Map_Grass
#Building Grid
@onready var BUILD_GRID: TileMapLayer = $World/Mapping/BuildingGrid
@onready var BLUEPRINT: Control = $World/Mapping/BuildingGrid/Blueprint_Control
#Camera
@onready var CAMERA_MAIN: Camera2D = $Camera_Main
#Time
@onready var TIME: Node2D = $World/Time
#Orphanages
@onready var ORPHANAGES: Node2D = $World/Orphanages
@onready var ORPHANAGE_BUILDINGS: Node2D = $World/Orphanages/Orphanage_Buildings
@onready var ORPHANAGE_FLORA: Node2D = $World/Orphanages/Orphanage_Flora
@onready var ORPHANAGE_ENTITES: Node2D = $World/Orphanages/Orphanage_Entities
