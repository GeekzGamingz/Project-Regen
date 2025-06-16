extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Exported Bools
@export var is_controllable: bool = true
@export var is_pathing: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var e: Node2D = get_parent().get_parent()
@onready var object_detection: Node2D = e.get_node("Raycasts/Ray_ObjectDetection")
@onready var navi: NavigationAgent2D = e.get_node("NavigationAgent2D")
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_interact"): activate_object()
	if event.is_action_pressed("move_click"): make_path()
	if Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	) != Vector2.ZERO: is_pathing = false
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_navi_velocity_computed(safe_velocity: Vector2) -> void:
	if is_pathing: e.velocity = safe_velocity
#------------------------------------------------------------------------------#
#Custom Functions
#Handle Movement Provided By Player
#WASD Controls
func handle_movement() -> void:
	if is_controllable: if e.is_multiplayer_authority():
		e.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if e.direction != Vector2.ZERO: MAIN.CAMERA_MAIN.position = e.position
#Click-to-Move
func handle_pathing() -> void:
	if is_controllable: if e.is_multiplayer_authority():
		var navi_position = global_position
		var next_position = navi.get_next_path_position()
		var new_velocity = navi_position.direction_to(next_position) * e.max_speed
		if navi.is_navigation_finished():
			is_pathing = false
			return
		if navi.avoidance_enabled: navi.set_velocity(new_velocity)
		else: _on_navi_velocity_computed(new_velocity)
		e.direction = round(to_local(navi.get_next_path_position()).normalized())
#Make Path
func make_path() -> void:
	navi.target_position = get_global_mouse_position()
	is_pathing = true
#Activate Object
func activate_object() -> void:
	if object_detection.is_colliding():
		object_detection.get_collider().get_node("../..").rpc("activate")
