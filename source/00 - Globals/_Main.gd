extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Scenes
#Network
@onready var NETWORK: Node2D = $Network
#User Interface
@onready var UI: CanvasLayer = $UserInterface
@onready var UI_NETWORK: HBoxContainer = $UserInterface/UI_FullRect/UI_Network
@onready var UI_CHAT: VBoxContainer = $UserInterface/UI_FullRect/UI_Network/VBoxContainer/UI_Chat
@onready var UI_CURSOR: TextureRect = $UserInterface/Cursor
@onready var MENU_TOOLS: HBoxContainer = $UserInterface/UI_FullRect/Menu_Tools
@onready var MENU_BUILDINGS: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Build/Menu_Buildings
@onready var MENU_FLORA: VBoxContainer = $UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Sow/Menu_Flora
#World Nodes
@onready var WORLD: Node2D = $World
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
@onready var ORPHANAGE_ENTITIES: Node2D = $World/Orphanages/Orphanage_Entities
@onready var ORPHANAGE_PLAYERS: Node2D = $World/Orphanages/Orphanage_Entities/Entities_Players
