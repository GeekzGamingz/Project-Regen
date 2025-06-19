extends CharacterBody2D
class_name Entity
#------------------------------------------------------------------------------#
#Variables
#Booleans
var is_grounded: bool = false
#Vectors
var facing: Vector2 = Vector2.ONE
var inversion: Vector2 = Vector2.ONE
var direction_previous: Vector2 = Vector2.ZERO
#Exported Variables
#Exported Floats
@export var speed: float = 2.5
#Exported Vectors
@export var direction: Vector2 = Vector2.ZERO
#OnReady Variables
@onready var walk_speed: float = speed * G.TILE_SIZE.x
@onready var run_speed: float = walk_speed * 2
@onready var max_speed: float = walk_speed
#Local Nodes
@onready var entity_fsm: Node2D = $Scripts/Entity_StateMachine
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
