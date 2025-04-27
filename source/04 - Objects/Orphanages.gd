extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal exit_build_mode
#Variables
var object_current: PackedScene
#Bool Variables
var buttons_connected: bool = false
#OnReady Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_released("action_confirm"):
		if !buttons_connected: buttons_connect()
		if G.IS_BUILDING: object_add()
	if event.is_action_released("action_cancel"):
		object_current = null
		emit_signal("exit_build_mode")
#------------------------------------------------------------------------------#
#Custom Functions
#Button Connection
func buttons_connect():
	for button in MAIN.MENU_BUILDINGS.get_children():
		if !button.has_connections("send_object"):
			button.connect("send_object", send_object)
			buttons_connected = true
	for button in MAIN.MENU_FLORA.get_children():
		if !button.has_connections("send_object"):
			button.connect("send_object", send_object)
#Instantiate Building
func object_add():
	G.CAN_BUILD = true
	buttons_connect()
	for ray in MAIN.BLUEPRINT.get_node("Blueprint_Selection").get_children():
		if ray.is_colliding(): G.CAN_BUILD = false
	if object_current != null && G.IS_BUILDING:
		if G.CAN_BUILD:
			var object_scene = object_current.instantiate()
			object_scene.global_position = MAIN.BLUEPRINT.global_position
			if object_scene.is_in_group("Buildings"):
				MAIN.ORPHANAGE_BUILDINGS.add_child(object_scene)
			elif object_scene.is_in_group("Flora"):
				MAIN.ORPHANAGE_FLORA.add_child(object_scene)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func send_object(object):
	object_current = object
	var object_scene = object_current.instantiate()
	var blueprint_preview = MAIN.BLUEPRINT.get_node("Blueprint_Preview")
	blueprint_preview.texture = object_scene.get_node("Sprite2D").texture
