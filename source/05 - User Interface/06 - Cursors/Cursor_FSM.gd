#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
var object_switch: bool = false
#OnReady Variables
@onready var cursor: Node2D = $".."
@onready var state_label: Label = $"../Outputs/Output_State"
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("default")
	state_add("hand_open")
	state_add("hand_grab")
	state_add("hold_object")
	state_add("hold_stack")
	state_add("new_object")
	call_deferred("state_set", states.default)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	match(state):
		states.default: pass
		states.hold_stack: cursor.output_quantity.text = str(cursor.quantity)
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Default
		states.default:
			match(cursor.icon_state):
				"HandOpen": return states.hand_open
				"HoldObject": return states.hold_object
		#Hand Open
		states.hand_open:
			match(cursor.icon_state):
				"Default": return states.default
				"HandGrab": return states.hand_grab
				"HoldObject": return states.hold_object
		#Hand Grab
		states.hand_grab:
			match(cursor.icon_state):
				"Default": return states.default
				"HandOpen": return states.hand_open
				"HoldObject": return states.hold_object
		#Hold Object
		states.hold_object:
			if cursor.object_held == null: return states.default
			if cursor.object_held.is_stackable == true: return states.hold_stack
			if object_switch == true: return states.new_object
		states.hold_stack:
			if cursor.quantity == 0: return states.default
			if cursor.object_held == null: return states.default
			if cursor.object_held.is_stackable == false: return states.hold_object
			if object_switch == true: return states.new_object
		states.new_object: return states.hold_object
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.default:
			cursor.object_held = null
			cursor.cursor.visible = false
			cursor.icon.visible = false
			cursor.object.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		states.hand_open:
			cursor.icon.texture = cursor.icon.CURSOR_HAND_OPEN_RIGHT
			cursor.icon.visible = true
		states.hand_grab:
			cursor.icon.texture = cursor.icon.CURSOR_HAND_GRAB_RIGHT
			cursor.icon.visible = true
		states.hold_object:
			cursor.icon.texture = cursor.icon.CURSOR_HAND_GRAB_RIGHT
			cursor.icon.visible = true
			if cursor.object_held != null:
				cursor.add_child(cursor.object_held)
				cursor.object.texture = cursor.object_held.sprite_preview.texture
				cursor.object_area.polygon = cursor.object_held.area_pack.polygon
				cursor.object.visible = true
				cursor.object.check_grid()
				cursor.remove_child(cursor.object_held)
		states.hold_stack: cursor.output_quantity.set_deferred("visible", true)
		states.new_object:
			object_switch = false
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.default: Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		states.hold_stack:cursor.output_quantity.set_deferred("visible", false)
