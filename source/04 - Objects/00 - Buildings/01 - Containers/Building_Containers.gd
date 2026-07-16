extends Interactable
#------------------------------------------------------------------------------#
#Variables
var menu: PanelContainer
#Bools
var spawned: bool = false
var opened: bool = false
#OnReady Variables
@export var container_interface: Resource
#------------------------------------------------------------------------------#
#Functions
#Input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_backpack"):
		var backpack = MAIN.UI_BACKPACK
		if menu != null && backpack.visible: menu.set_deferred("visible", false)
#Signaled Functions
#On Detection Exited
func _on_detection_area_exited(area: Area2D) -> void:
	if area.get_node("../..").name == str(multiplayer.get_unique_id()) && menu != null: toggle_opened(false)
#------------------------------------------------------------------------------#
#Custom Functions
#Interact
func interact():
	if !spawned: rpc("spawn_container")
	toggle_opened(true)
#Open Container
func toggle_opened(toggle):
	menu.set_deferred("visible", toggle)
	opened = toggle
#------------------------------------------------------------------------------#
#Custom Remote Procedural Calls
#Spawn Container
@rpc("any_peer", "call_local")
func spawn_container():
	var container_scene = container_interface.instantiate()
	var inventory = MAIN.UI_INVENTORY
	inventory.add_child(container_scene)
	menu = container_scene
	spawned = true
