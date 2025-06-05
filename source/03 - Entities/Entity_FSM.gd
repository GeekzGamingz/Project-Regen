#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var e: Entity = get_parent().get_parent()
@onready var p_move: Node2D = get_parent().get_node("Player_Input")
@onready var state_label: Label = e.get_node("Outputs/Output_State")
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("idle_left")
	state_add("idle_right")
	state_add("idle_up")
	state_add("idle_down")
	state_add("walk_left")
	state_add("walk_right")
	state_add("walk_up")
	state_add("walk_down")
	call_deferred("state_set", states.idle_down)
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
		states.idle_down: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Idle
		states.idle_left: return directional_transitions()
		states.idle_right: return directional_transitions()
		states.idle_down: return directional_transitions()
		states.idle_up: return directional_transitions()
		#Walk
		states.walk_left:
			if e.direction == Vector2.ZERO: return states.idle_left
			else: return directional_transitions()
		states.walk_right:
			if e.direction == Vector2.ZERO: return states.idle_right
			return directional_transitions()
		states.walk_up:
			if e.direction == Vector2.ZERO: return states.idle_up
			return directional_transitions()
		states.walk_down:
			if e.direction == Vector2.ZERO: return states.idle_down
			return directional_transitions()
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.idle_right: e.playback.travel("Idle")
		states.idle_left:
			e.playback.travel("Idle")
		states.idle_up: e.playback.travel("Idle")
		states.idle_down: e.playback.travel("Idle")
		states.walk_left:
			e.playback.travel("Walk")
			e.object_detection.target_position = Vector2(-G.TILE_SIZE.x, 0)
		states.walk_right:
			e.playback.travel("Walk")
			e.object_detection.target_position = Vector2(G.TILE_SIZE.x, 0)
		states.walk_up:
			e.playback.travel("Walk")
			e.object_detection.target_position = Vector2(0, -G.TILE_SIZE.x)
		states.walk_down:
			e.playback.travel("Walk")
			e.object_detection.target_position = Vector2(0, G.TILE_SIZE.x)
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle_down: pass
#------------------------------------------------------------------------------#
#Custom Functions
#Directional Transitions
func directional_transitions():
	if e.direction == Vector2.LEFT:
		e.direction_previous = e.direction
		return states.walk_left
	elif e.direction == Vector2.RIGHT:
		e.direction_previous = e.direction
		return states.walk_right
	elif e.direction == Vector2.UP:
		e.direction_previous = e.direction
		return states.walk_up
	elif e.direction == Vector2.DOWN:
		e.direction_previous = e.direction
		return states.walk_down
#Update Animation Blending
func update_blending():
	e.anim_tree["parameters/Idle/blend_position"] = e.direction_previous
	e.anim_tree["parameters/Walk/blend_position"] = e.direction
