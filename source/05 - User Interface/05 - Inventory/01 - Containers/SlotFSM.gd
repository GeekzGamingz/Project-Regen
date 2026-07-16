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
	state_add("blocking")
	call_deferred("state_set", states.empty)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	match(state):
		states.empty: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Empty
		states.empty:
			if s.slotted_object != null: return states.full
			if s.slot_blocked && !s.main_container.visible: return states.blocking
		#Full
		states.full:
			if s.slotted_object == null: return states.empty
			if s.slot_held.visible: return states.selected
			if s.slot_blocked: return states.blocking
		#Selected
		states.selected:
			if s.slotted_object == null: return states.empty
			if !s.slot_held.visible: return states.full
		states.blocking:
			if s.slot_held.visible: return states.selected
			if !s.slot_blocked:  return states.full
			if s.main_container.visible && s.slotted_object == null: return states.empty
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.empty: 
			if s.main_container.name != "Backpack": s.clear_slot.rpc()
			else: s.clear_slot()
		states.full: s.update_slot()
		states.selected:
			s.object_highlight(true)
			s.area.get_node("CollisionShape2D").set_deferred("disabled", true)
		states.blocking:
			s.area.get_node("CollisionShape2D").set_deferred("disabled", true)
			print(s.name, " Blocked!")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.empty: pass
		states.selected:
			s.object_highlight(false)
			s.area.get_node("CollisionShape2D").set_deferred("disabled", false)
		states.blocking:
			s.area.get_node("CollisionShape2D").set_deferred("disabled", false)
			print(s.name, " Unblocked!")
