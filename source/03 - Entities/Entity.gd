extends CharacterBody2D
class_name Entity
#------------------------------------------------------------------------------#
#Constants
const FACING_LEFT: int = -1
const FACING_RIGHT: int = 1
const UP_SIDE_DOWN: int = -1
const RIGHT_SIDE_UP: int = 1
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
#Facing Orientations
#Horizontal Facing
func set_facing(hor_facing: int) -> void:
	if hor_facing == 0:
		hor_facing = FACING_RIGHT
	var hor_face_mod = hor_facing / abs(hor_facing)
	$Facing.apply_scale(Vector2(hor_face_mod * facing.x, 1))
	$CollisionShape2D.position.x *= -1
	facing = Vector2(hor_face_mod, facing.y)
#Vertical Facing
func set_vert(vert_facing: int) -> void:
	if vert_facing == 0:
		vert_facing = RIGHT_SIDE_UP
	var vert_face_mod = vert_facing / abs(vert_facing)
	$Facing.apply_scale(Vector2(1, vert_face_mod * inversion.x))
	$CollisionShape2D.position.y *= -1
	inversion = Vector2(vert_face_mod, inversion.y)
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
