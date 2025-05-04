extends TileMapLayer
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var buildings: Array[PackedScene]
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var MENU_BUILDINGS: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Build/Menu_Buildings")
@onready var MENU_FLORA: VBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/Menu_Tools/VBoxContainer/Menu_Sow/Menu_Flora")
@onready var ORPHANAGES: Node2D = MAIN.get_node("World/Orphanages")
@onready var BLUEPRINT: Control = MAIN.get_node("World/Mapping/BuildingGrid/Blueprint_Control")
#Blueprint Nodes
@onready var blueprint_zone = BLUEPRINT.get_node("Blueprint_Zone")
@onready var blueprint_selection = BLUEPRINT.get_node("Blueprint_Selection")
@onready var viewport_size = get_viewport_rect().size
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	MENU_BUILDINGS.connect("change_selection", change_selection)
	MENU_FLORA.connect("change_selection", change_selection)
	ORPHANAGES.connect("exit_build_mode", exit_build_mode)
#------------------------------------------------------------------------------#
#Process Function
func _process(_delta: float) -> void:
	check_cell()
	check_zone() #Update Cell
#------------------------------------------------------------------------------#
#Custom Functions
#Check Cell
func check_cell() -> void:
	var mouse_tile = get_global_mouse_position() #Position of Mouse
	var map_position = local_to_map(mouse_tile) #Convert to Map
	var cell_position = map_to_local(map_position) #Convert to Local Coordinates
	BLUEPRINT.position = to_global(cell_position) - (G.TILE_SIZE * 0.5)
#Zone Color
func check_zone() -> void:
	if G.IS_BUILDING:
		blueprint_zone.self_modulate = Color(Color.WHITE)
		for ray in blueprint_selection.get_children():
			if ray.is_colliding(): blueprint_zone.self_modulate = Color(Color.RED)
#Blueprint Visibility
func blueprint_visibility(toggle: bool):
	BLUEPRINT.set_deferred("visible", toggle)
	if toggle: Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Selection Dimensions
func change_selection(dimensions): 
	var texture_size: Vector2 = Vector2.ZERO
	blueprint_visibility(true)
	match(dimensions.find_key(true)):
		"16x16":
			texture_size = Vector2(16, 16)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_16x16"]
		"16x32":
			texture_size = Vector2(16, 32)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_16x32"]
		"16x48":
			texture_size = Vector2(16, 48)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_16x48"]
		"16x64":
			texture_size = Vector2(16, 64)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_16x64"]
		"32x16":
			texture_size = Vector2(32, 16)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_32x16"]
		"32x32":
			texture_size = Vector2(32, 32)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_32x32"]
		"32x48":
			texture_size = Vector2(32, 48)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_32x48"]
		"32x64":
			texture_size = Vector2(32, 64)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_32x64"]
		"48x16":
			texture_size = Vector2(48, 16)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_48x16"]
		"48x32":
			texture_size = Vector2(48, 32)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_48x32"]
		"48x48":
			texture_size = Vector2(48, 48)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_48x48"]
		"48x64":
			texture_size = Vector2(48, 64)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_48x64"]
		"64x16":
			texture_size = Vector2(64, 16)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_64x16"]
		"64x32":
			texture_size = Vector2(64, 32)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_64x32"]
		"64x48":
			texture_size = Vector2(64, 48)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_64x48"]
		"64x64":
			texture_size = Vector2(64, 64)
			blueprint_zone.texture = G.ZONE_TEXTURES["ZONE_64x64"]
	blueprint_selection.size = texture_size
	for ray in blueprint_selection.get_children():
		ray.target_position.y = (texture_size.x + texture_size.y) * 0.5
		ray.position = Vector2(texture_size.x * 0.5, texture_size.y * 0.5)
#Exit Build Mode
func exit_build_mode():
	G.IS_BUILDING = false
	blueprint_visibility(false)
	MENU_BUILDINGS.set_deferred("visible", false)
	MENU_FLORA.set_deferred("visible", false)
