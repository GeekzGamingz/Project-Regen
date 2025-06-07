extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var is_controllable: bool = true
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
@onready var entity: Node2D = get_parent().get_parent()
@onready var object_detection: Node2D = entity.get_node("Raycasts/Ray_ObjectDetection")
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_interact"): activate_object()
#Custom Functions
#Handle Movement Provided By Player
func handle_movement() -> void:
	if is_controllable:
		if entity.is_multiplayer_authority():
			entity.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if entity.direction != Vector2.ZERO: MAIN.CAMERA_MAIN.position = entity.position
#Activate Object
func activate_object() -> void:
	if object_detection.is_colliding(): object_detection.get_collider().rpc("activate")
