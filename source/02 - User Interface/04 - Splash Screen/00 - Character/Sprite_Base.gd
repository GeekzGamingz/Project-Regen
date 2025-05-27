extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var height_counter: int = 1
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var splash_screen: Control = $"../../../../../../../../.."
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	#Connections
	ui_customization.connect("uic_height_change", uic_height_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_height_change(scroll):
	match(scroll):
		"Previous": height_counter -= 1
		"Next": height_counter += 1
	if height_counter == bases_average.size(): height_counter = 0
	elif height_counter < 0: height_counter = bases_average.size() -1
	check_base()
#Check Base Texture
func check_base():
	#If Player is Average
	if !sprites_character.sprite_info["chub"]: texture = bases_average[height_counter]
	#If Player is Chubby
	if sprites_character.sprite_info["chub"]: texture = bases_chub[height_counter]
