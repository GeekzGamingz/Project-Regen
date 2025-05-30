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
@onready var selection_character: HBoxContainer = $"../../../../.."
@onready var splash_screen: Control = $"../../../../../../../../../.."
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_height_change", uic_height_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_height_change(scroll):
	match(scroll):
		"Previous": height_counter -= 1
		"Next": height_counter += 1
	if height_counter == bases_average.size(): height_counter = 0
	elif height_counter < 0: height_counter = bases_average.size() -1
	sprites_character.sprite_info["height"] = height_counter
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	if selection_character.is_new:
		if !sprites_character.sprite_info["chub"]: texture = bases_average[height_counter]
		elif sprites_character.sprite_info["chub"]: texture = bases_chub[height_counter]
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles 
		if !profiles[counter].get("chub"):
			texture = bases_average[int(profiles[counter].get("height"))]
		elif profiles[counter].get("chub"):
			texture = bases_chub[int(profiles[counter].get("height"))]
