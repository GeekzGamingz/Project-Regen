extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
var held_slots: int = 0
#OnReady Variables
@onready var axis: Node2D = $".."
@onready var cursor_fsm: Node2D = $"../../../Cursor_StateMachine"
@onready var area_containers: Area2D = $Area_Containers
@onready var area_poly: CollisionPolygon2D = $Area_Containers/CollisionPolygon2D
@onready var grid_container: GridContainer = $GridContainer
#------------------------------------------------------------------------------#
#Functions
#Input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_rotate"):
		var states = cursor_fsm.states
		if [states.hold_object, states.hold_stack].has(cursor_fsm.state): rotate_hand()
#------------------------------------------------------------------------------#
#Custom Functions
#Hand Rotation
func rotate_hand():
	print("Rotating Hand [", held_slots, " Slots]")
	axis.rotation_degrees += 90
	if axis.rotation_degrees >= 360: axis.rotation = 0
#Revert Hand
func revert_hand():
	for selection in grid_container.get_children():
		var ray = selection.get_node("RayCast2D")
		ray.enabled = false
	held_slots = 0
#Shape Grid
func shape_grid():
	area_poly.disabled = false #Reset Polygon
	await get_tree().process_frame
	for selection in grid_container.get_children():
		var ray = selection.get_node("RayCast2D")
		ray.enabled = true #Reset RayCast2D
		ray.force_raycast_update()
		#Set Self-Modulation Not Visibility Due to Grid Container
		if !ray.is_colliding():
			selection.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
			ray.set_deferred("enabled", false)
		else:
			selection.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			held_slots += 1
	area_poly.set_deferred("disabled", true)
