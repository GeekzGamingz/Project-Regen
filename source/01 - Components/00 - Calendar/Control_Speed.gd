extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var timer: Timer = $"../Timer_Ticks"
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	control_speed(event)
#------------------------------------------------------------------------------#
#Custom Functions
func control_speed(event):
	#Increase Speed
	if event.is_action_pressed("speed_normal"): #Normal Speed
		timer.wait_time = 1.0
	if event.is_action_pressed("speed_double"): #Double Speed
		timer.wait_time = 0.5
	if event.is_action_pressed("speed_triple"): #Triple Speed
		timer.wait_time = 0.25
	if event.is_action_pressed("speed_decuple"): #Decuple Speed
		timer.wait_time = 0.1
	#Decrease Speed
	if event.is_action_pressed("speed_half"): #Half Speed
		timer.wait_time = 2
	if event.is_action_pressed("speed_fifth"): #Fifth Speed
		timer.wait_time = 5
	#Halt Speed
	if event.is_action_pressed("speed_pause"):
		get_tree().paused = !get_tree().paused
