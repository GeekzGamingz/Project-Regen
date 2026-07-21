@tool
extends SpriteTextures
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Exported Enumerations
@export_enum("Short", "Average", "Tall") var height: String = "Average":
	set(new_setting):
		height = new_setting
		update_sprites()
#Exported Bools
@export var is_chub: bool = false:
	set(new_setting):
		is_chub = new_setting
		update_sprites()
@export var is_wheels: bool = false:
	set(new_setting):
		is_wheels = new_setting
		update_sprites()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Sprites
func update_sprites():
	var body: Node2D = $"../../Sprites/Sprites_Body"
	var offset: float
	var offset_sprites: Array = [
		body.get_node("Sprite_Hair"),
		body.get_node("Sprite_Ears"),
		body.get_node("Sprite_Beard"),
		body.get_node("Sprite_Bangs")
	]
	var sprite_string: String = ""
	match(is_chub):
		false: match(height):
			"Short":
				sprite_string = "S_S_NW" #Short Average No Wheelchair
				offset = -14.0
			"Average":
				sprite_string = "A_S_NW" #Average Average No Wheelchair
				offset = -16.0
			"Tall":
				sprite_string = "T_S_NW" #Tall Average No Wheelchair
				offset = -18.0
		true: match(height):
			"Short":
				sprite_string = "S_C_NW" #Short Chubby No Wheelchair
				offset = -14.0
			"Average":
				sprite_string = "A_C_NW" #Average Chubby No Wheelchair
				offset = -16.0
			"Tall":
				sprite_string = "T_C_NW" #Tall Chubby No Wheelchair
				offset = -18.0
	body.get_node("Sprite_Base").texture = TORSO[sprite_string]
	body.get_node("Sprite_ArmLeft").texture = ARM_L[sprite_string]
	body.get_node("Sprite_ArmRight").texture = ARM_R[sprite_string]
	body.get_node("Sprite_LegLeft").texture = LEG_L[sprite_string]
	body.get_node("Sprite_LegRight").texture = LEG_R[sprite_string]
	for sprite in offset_sprites: sprite.offset.y = offset
