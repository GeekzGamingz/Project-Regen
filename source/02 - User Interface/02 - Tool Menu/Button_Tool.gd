extends TextureButton
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var menu: VBoxContainer
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var ORPHANAGES: Node2D = MAIN.get_node("World/Orphanages")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	ORPHANAGES.connect("exit_build_mode", _on_button_up)
#Signaled Functions
#Button Up
func _on_button_up() -> void:
	#Visibility Toggles
	menu.set_deferred("visible", !menu.visible)
#Mouse Entered
func _on_mouse_entered() -> void:
	if G.CAN_BUILD: G.CAN_BUILD = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#Mouse Exited
func _on_mouse_exited() -> void:
	if !G.CAN_BUILD: G.CAN_BUILD = true
	else: G.CAN_BUILD = false
	if G.IS_BUILDING: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
