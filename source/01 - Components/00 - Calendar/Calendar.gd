extends Node2D
#------------------------------------------------------------------------------#
#Signals
signal update_calendar
signal month_elapsed
signal season_elapsed
#------------------------------------------------------------------------------#
#Constants
const DAYS_WEEKLY: int = 5 #Days Per Week
const DAYS_MONTHLY: int = 15 #Days Per Month
const WEEKS_MONTHLY: int = 3 #Weeks Per Months
const MONTHS_SEASONLY: int = 2 #Months Per Season
const MONTHS_ANNUALLY: int = 10 #Months Per Year
const SEASONS_ANNUALLY: int = 5 #Season Per Year
#------------------------------------------------------------------------------#
#Variables
var day: int #Current Day of Week
var month: int #Current Month of the Year
var week: int #Current Quality/Week of the Month
var season: int #Current Season
#Exported Variables
@export var ticks: int = 0
@export var day_length: int = 26
#Exported Enumerations
#Weekdays
@export var weekdays: Array[String] = ["New", "Waxing", "Half", "Waning", "Full"]
@export var weeks: Array[String] = ["Crescent", "Blood", "Gibbous"]
@export var months: Array[String] = [
	"Horizon", "Sun", "Star", "Moon", "Eclipse",
	"Meteor", "Comet", "Planet", "Nova", "Galaxy"
]
@export var seasons: Array[String] = ["Sowing", "Growth", "Tending", "Harvest", "Rest"]
#OnReady Variables
@onready var week_length = day_length * DAYS_WEEKLY
@onready var month_length = day_length * DAYS_MONTHLY
@onready var season_length = day_length * DAYS_MONTHLY * MONTHS_SEASONLY
@onready var year_length = day_length * DAYS_MONTHLY * MONTHS_ANNUALLY
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	check_cycles()
	emit_signal(
		"update_calendar",
		weekdays[day], weeks[week], months[month], seasons[season]
		)
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_timer_ticks_timeout() -> void:
	#var yesterday = day - 1
	#var tomorrow = day + 1
	#var elapsed = snapped((float(ticks) / day_length), 0.01)
	#if tomorrow == DAYS_WEEKLY: tomorrow = 0
	##-----Print Block-----#
	#print("#---TICK!---#")
	#print("Current Tick: ", ticks)
	#print("Days Elapsed: ", int(elapsed))
	#print(
		#"Today: ", weekdays[day], " (", day, ") ",
		#"[Yesterday: ", weekdays[yesterday], " (", yesterday, ")] ",
		#"[Tomorrow: ", weekdays[tomorrow], " (", tomorrow, ")]"
	#)
	#print(
		#"Current Month: ", months[month], " (", month, ") ",
		#"[Current Week: ", weeks[week], " (", week, ")]")
	#print("Current Season: Season of ", seasons[season], " (", season, ")]")
	#-----Print Block-----#
	ticks += 1
	if ticks % int(day_length * 0.5) == 0: check_cycles() #Bi-Daily Event
	if ticks % day_length == 0:  #Daily Event
		print("[DAILY EVENT -- !Random Timer Activated!]")
		day += 1
		check_cycles()
	if ticks % week_length == 0: #Weekly Event
		print("[WEEKLY EVENT  -- !Random Timer Activated!]")
		week += 1
		check_cycles()
	if ticks % month_length == 0: #Monthly Event
		print("[MONTHLY EVENT  -- !Random Timer Activated!]")
		month += 1
		check_cycles()
		emit_signal("month_elapsed", months[month])
	if ticks % season_length == 0: #Seasonly Event
		print("[SEASONLY EVENT  -- !Random Timer Activated!]")
		season += 1
		check_cycles()
		emit_signal("season_elapsed", seasons[season])
	emit_signal(
		"update_calendar",
		weekdays[day], weeks[week], months[month], seasons[season]
		)
#------------------------------------------------------------------------------#
#Custom Functions
#Check Cycle
func check_cycles():
	G.CURRENT_TICK = ticks
	if day == DAYS_WEEKLY: day = 0
	if week == WEEKS_MONTHLY: week = 0
	if month == MONTHS_ANNUALLY: month = 0
	if season == SEASONS_ANNUALLY: season = 0
