extends VBoxContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var TIME: Node2D = MAIN.get_node("World/Time")
#Labels
@onready var time_labels: VBoxContainer = $Time_Contents/Time_Labels
@onready var label_day: Label = $Time_Contents/Time_Labels/Labels_TopRow/Label_Day
@onready var label_week: Label = $Time_Contents/Time_Labels/Labels_TopRow/Label_Week
@onready var label_month: Label = $Time_Contents/Time_Labels/Labels_TopRow/Label_Month
@onready var label_season: Label = $Time_Contents/Time_Labels/Labels_BottomRow/Label_Season
@onready var clock_labels: VBoxContainer = $Time_Contents/UI_Clock/Clock_Labels
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	TIME.connect("update_time", update_time)
#------------------------------------------------------------------------------#
#Signaled Functions
#Mouse Entered
func _on_ui_clock_mouse_entered() -> void:
	time_labels.set_deferred("visible", true)
	clock_labels.set_deferred("visible", true)
#Mouse Exited
func _on_ui_clock_mouse_exited() -> void:
	time_labels.set_deferred("visible", false)
	clock_labels.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func update_time(day, week, month, season):
	label_day.text = day
	label_week.text = week
	label_month.text = month
	label_season.text = str("of ", season)
