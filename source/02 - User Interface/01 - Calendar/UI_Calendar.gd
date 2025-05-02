extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var CALENDAR: Node2D = MAIN.get_node("Calendar")
#Labels
@onready var calendar_labels: VBoxContainer = $Calendar_Contents/Calendar_Labels
@onready var label_day: Label = $Calendar_Contents/Calendar_Labels/Labels_TopRow/Label_Day
@onready var label_week: Label = $Calendar_Contents/Calendar_Labels/Labels_TopRow/Label_Week
@onready var label_month: Label = $Calendar_Contents/Calendar_Labels/Labels_TopRow/Label_Month
@onready var label_season: Label = $Calendar_Contents/Calendar_Labels/Labels_BottomRow/Label_Season
@onready var clock_labels: VBoxContainer = $Calendar_Contents/UI_Clock/Clock_Labels
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	CALENDAR.connect("update_calendar", update_calendar)
#------------------------------------------------------------------------------#
#Signaled Functions
#Mouse Entered
func _on_ui_clock_mouse_entered() -> void:
	calendar_labels.set_deferred("visible", true)
	clock_labels.set_deferred("visible", true)
#Mouse Exited
func _on_ui_clock_mouse_exited() -> void:
	calendar_labels.set_deferred("visible", false)
	clock_labels.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_calendar(day, week, month, season):
	label_day.text = day
	label_week.text = week
	label_month.text = month
	label_season.text = str("of ", season)
