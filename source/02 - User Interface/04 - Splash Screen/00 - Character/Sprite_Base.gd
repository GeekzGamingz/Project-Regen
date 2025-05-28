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
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	#If Player is Average
	if !sprites_character.is_chub: texture = bases_average[height_counter]
	#If Player is Chubby
	if sprites_character.is_chub: texture = bases_chub[height_counter]
##Save Skin Colors
#func save_skin(color_id):
	#var customize_type = "Skin"
	#var id = multiplayer.get_unique_id()
	#e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
##Save Eye Colors
#func save_eyes(color_id, eyes_linked, lateral):
	#var id = multiplayer.get_unique_id()
	#match(lateral):
		#"Eye1":
			#var customize_type = "EyeRight"
			#e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
			#if eyes_linked:
				#customize_type = "EyeLeft"
				#e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
		#"Eye2":
			#var customize_type = "EyeLeft"
			#e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
			#if eyes_linked:
				#customize_type = "EyeRight"
				#e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
