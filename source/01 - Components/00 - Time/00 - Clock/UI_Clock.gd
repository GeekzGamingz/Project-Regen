extends TextureRect
#------------------------------------------------------------------------------#
#Variables
var hour: int = 13
var meridiem_str: String = str("Before Midday")
var meridiem_switch = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
#Sprites
@onready var clock_daynight: TextureRect = $Clock_DayNight
@onready var clock_hand: TextureRect = $Clock_Hand
#Labels
@onready var label_time: Label = $Clock_Labels/Label_Time
@onready var label_meridiem: Label = $Clock_Labels/Label_Meridiem
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	await get_tree().process_frame
	MAIN.TIME.connect("tick_elapsed", tick_elapsed)
	update_labels()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Ticks Elapsed
func tick_elapsed(_ticks):
	clock_hand.rotation_degrees += 360.0 / (MAIN.TIME.day_length * 0.5)
	clock_daynight.rotation_degrees -= 360.0 / (MAIN.TIME.day_length)
	hour += 1
	update_labels()
#Update TIME Labels
func update_labels() -> void:
	if hour == (MAIN.TIME.day_length * 0.5) + 1:
		hour = 1
		meridiem_switch = !meridiem_switch
		match(meridiem_switch):
			true: meridiem_str = str("Before Midday")
			false: meridiem_str = str("After Midday")
	var ordinal_str
	match(hour):
		1: ordinal_str = str("st")
		2: ordinal_str = str("nd")
		3: ordinal_str = str("rd")
		4, 5, 6, 7, 8, 9, 10, 11, 12, 13: ordinal_str = str("th")
	label_time.text = str(hour, ordinal_str, " Hour")
	label_meridiem.text = str(meridiem_str)
