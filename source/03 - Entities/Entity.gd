extends CharacterBody2D
class_name Entity
#------------------------------------------------------------------------------#
#Variables
#Bools
var is_grounded: bool = false
#Vectors
var facing: Vector2 = Vector2.ONE
var inversion: Vector2 = Vector2.ONE
var direction: Vector2 = Vector2.ZERO
var direction_previous: Vector2 = Vector2.ZERO
#Exported Variables
#Floats
@export var speed: float = 2.5
#Bools
#OnReady Variables
@onready var walk_speed: float = speed * G.TILE_SIZE.x
@onready var run_speed: float = walk_speed * 2
@onready var max_speed: float = walk_speed
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
@onready var UI_NETWORK: HBoxContainer = MAIN.get_node("UserInterface/UI_FullRect/UI_Network")
#Local Nodes
@onready var entity_colors: Node2D = $Scripts/Entity_Customization/Entity_Colors
#RayCasts
@onready var object_detection: RayCast2D = $Raycasts/Ray_ObjectDetection
#Animation Nodes
@onready var sprite_player: AnimationPlayer = $AnimationPlayers/AnimPlayer_Sprite
@onready var fx_player: AnimationPlayer = $AnimationPlayers/AnimPlayer_Effects
@onready var anim_tree: AnimationTree = $AnimationPlayers/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")
@onready var pb_state: String = playback.get_current_node()
#------------------------------------------------------------------------------#
#Custom Functions
#Movement
func apply_movement() -> void:
	velocity = lerp(velocity, direction * max_speed, weight())
	move_and_slide()
#------------------------------------------------------------------------------#
#Entity Weight
func weight() -> float:
	#Ground Weight
	if is_grounded:
		if direction.is_zero_approx(): return 0.9 #Slow-to-Stop
		elif velocity.x != 0 && max_speed == run_speed: return 0.05 #Running
		else: return 0.2 #Walking
	#Air Weight
	else: return 0.1
