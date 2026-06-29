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
	var dimensions_key: String = dimensions.find_key(true)
	var dimension_split: Array = dimensions_key.split("x")
	texture_size = Vector2(int(dimension_split[0]), int(dimension_split[1]))
	blueprint_zone.texture = T.ZONE[str("ZONE_", dimension_split[0], "x", dimension_split[1])]
	blueprint_selection.size = texture_size
	for ray in blueprint_selection.get_children():
		ray.target_position.y = (texture_size.x + texture_size.y) * 0.5
		ray.position = Vector2(texture_size.x * 0.5, texture_size.y * 0.5)
	blueprint_visibility(true)
#Exit Build Mode
func exit_build_mode():
	G.IS_BUILDING = false
	blueprint_visibility(false)
	MENU_BUILDINGS.set_deferred("visible", false)
	MENU_FLORA.set_deferred("visible", false)
