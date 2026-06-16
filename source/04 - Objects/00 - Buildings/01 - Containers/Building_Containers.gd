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
func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Entity_Player" && menu != null: close()
#------------------------------------------------------------------------------#
#Custom Functions
#Interact
func interact():
	match(spawned):
		true: menu.set_deferred("visible", true)
		false:
			var container_scene = container_interface.instantiate()
			var inventory = MAIN.UI_INVENTORY
			inventory.add_child(container_scene)
			menu = container_scene
			spawned = true
	opened = true
#Open Container
func close():
	menu.set_deferred("visible", false)
	opened = false
