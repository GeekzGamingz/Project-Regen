extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var CALENDAR: Node2D = MAIN.get_node("Calendar")
#Labels
@onready var label_day: Label = $HBoxContainer/Label_Day
@onready var label_week: Label = $HBoxContainer/Label_Week
@onready var label_month: Label = $HBoxContainer/Label_Month
@onready var label_season: Label = $HBoxContainer/Label_Season
#Sprites
@onready var clock_hand: Sprite2D = $HBoxContainer/UI_Clock/Clock_Hand
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	CALENDAR.connect("update_calendar", update_calendar)
#------------------------------------------------------------------------------#
#Custom Functions
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_calendar(day, week, month, season):
	label_day.text = day
	label_week.text = week
	label_month.text = month
	label_season.text = str("of ", season)
	clock_hand.rotation_degrees += 360.0 / 13.0
		
	
