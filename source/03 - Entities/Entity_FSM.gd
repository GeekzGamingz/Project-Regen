#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var e: Entity = get_parent().get_parent()
@onready var p_move: Node2D = get_parent().get_node("Player_Movement")
@onready var state_label: Label = e.get_node("Outputs/Output_State")
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("idle")
	state_add("walk_left")
	state_add("walk_right")
	state_add("walk_up")
	state_add("walk_down")
	call_deferred("state_set", states.idle)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	update_blending()
	state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	p_move.handle_movement()
	e.apply_movement()
	match(state):
		states.idle: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Idle
		states.idle: return directional_transitions()
		
		#Walk
		states.walk_left: return directional_transitions()
		states.walk_right: return directional_transitions()
		states.walk_up: return directional_transitions()
		states.walk_down: return directional_transitions()
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.idle: e.playback.travel("Idle")
		states.walk_left: e.playback.travel("Walk")
		states.walk_right: e.playback.travel("Walk")
		states.walk_up: e.playback.travel("Walk")
		states.walk_down: e.playback.travel("Walk")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle: pass
#------------------------------------------------------------------------------#
#Custom Functions
#Directional Transitions
func directional_transitions():
	if e.direction == Vector2.ZERO: return states.idle
	elif e.direction == Vector2.LEFT: return states.walk_left
	elif e.direction == Vector2.RIGHT: return states.walk_right
	elif e.direction == Vector2.UP: return states.walk_up
	elif e.direction == Vector2.DOWN: return states.walk_down
#Update Animation Blending
func update_blending():
	e.anim_tree["parameters/Walk/blend_position"] = e.direction
