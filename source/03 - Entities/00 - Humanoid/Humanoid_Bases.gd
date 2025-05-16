extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var e_customization: Node2D = $"../../Scripts/Entity_Customization"
#------------------------------------------------------------------------------#
#Check Base Texture
func check_base():
	if !e_customization.is_chub: texture = bases_average[e_customization.height_counter]
	if e_customization.is_chub: texture = bases_chub[e_customization.height_counter]
