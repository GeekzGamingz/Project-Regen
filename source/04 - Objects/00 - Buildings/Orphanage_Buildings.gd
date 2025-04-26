extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal exit_build_mode
#Variables
var building_current: PackedScene
#Bool Variables
var buttons_connected: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_released("action_confirm"):
		if !buttons_connected: buttons_connect()
		if G.IS_BUILDING: building_add()
	if event.is_action_released("action_cancel"):
		if G.IS_BUILDING:
			emit_signal("exit_build_mode")
			G.IS_BUILDING = false
			building_current = null
#------------------------------------------------------------------------------#
#Custom Functions
#Button Connection
func buttons_connect():
	for button in MAIN.MENU_BUILDINGS.get_children():
		if !button.has_connections("send_building"):
			button.connect("send_building", send_building)
			buttons_connected = true
#Instantiate Building
func building_add():
	G.CAN_BUILD = true
	for button in MAIN.MENU_BUILDINGS.get_children():
		if !button.has_connections("send_building"):
			button.connect("send_building", send_building)
			buttons_connected = true
	for ray in MAIN.BLUEPRINT.get_node("Blueprint_Selection").get_children():
		if ray.is_colliding(): G.CAN_BUILD = false
	if building_current != null && G.IS_BUILDING:
		if G.CAN_BUILD:
			var building_scene = building_current.instantiate()
			building_scene.global_position = MAIN.BLUEPRINT.global_position
			add_child(building_scene)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func send_building(building):
	building_current = building
	var building_scene = building_current.instantiate()
	var blueprint_preview = MAIN.BLUEPRINT.get_node("Blueprint_Preview")
	blueprint_preview.texture = building_scene.get_node("Sprite2D").texture
