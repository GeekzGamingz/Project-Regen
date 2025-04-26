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
	state_add("walk")
	call_deferred("state_set", states.idle)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
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
		states.idle:
			if !e.velocity.is_zero_approx():
				if e.max_speed == e.walk_speed: return states.walk
		#Walk
		states.walk:
			if e.velocity.is_zero_approx(): return states.idle
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state): pass
	#match(new_state):
		#states.idle: e.playback.travel("idle")
		#states.walk: e.playback.travel("walk")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle: pass
