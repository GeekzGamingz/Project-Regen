#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables

#OnReady Variables
@onready var s: TextureRect = $".."
@onready var state_label: Label = $"../Output_State"
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("empty")
	state_add("full")
	state_add("selected")
	call_deferred("state_set", states.empty)
#------------------------------------------------------------------------------#
#State Label
#func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	match(state):
		states.empty: pass
		states.full: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Empty
		states.empty: if s.slotted_object != null: return states.full
		#Full
		states.full:
			if s.slotted_object == null: return states.empty
			if s.slot_held.visible: return states.selected
		#Selected
		states.selected: if s.slotted_object == null: return states.empty
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.empty: s.clear_slot()
		states.full: s.update_slot()
		states.selected:
			s.object_highlight(true)
			s.area.get_node("CollisionShape2D").set_deferred("disabled", true)
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.empty: pass
		states.selected:
			s.object_highlight(false)
			s.area.get_node("CollisionShape2D").set_deferred("disabled", false)
