extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Arrays
@export_category("Average")
@export var arms_right_short_average: Array[Resource] = []
@export var arms_right_average_average: Array[Resource] = []
@export var arms_right_tall_average: Array[Resource] = []
@export_category("Chub")
@export var arms_right_short_chub: Array[Resource] = []
@export var arms_right_average_chub: Array[Resource] = []
@export var arms_right_tall_chub: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../../.."
@onready var entity_colors: Node2D = e.get_node("Scripts/Entity_Customization/Entity_Colors")
#------------------------------------------------------------------------------#
#Custom Functions
func check_arm_right():
	for player in e.get_parent().get_children():
		var arm_right = player.get_node("Sprites/Sprites_Body/Sprite_ArmRight")
		for id in e.NETWORK.players: if player.name == str(id):
			match(e.NETWORK.players[id].get("chub")):
				false: match(e.NETWORK.players[id].get("height")):
					0: arm_right.texture = arms_right_short_average[e.NETWORK.players[id].get("arm_right")]
					1: arm_right.texture = arms_right_average_average[e.NETWORK.players[id].get("arm_right")]
					2: arm_right.texture = arms_right_tall_average[e.NETWORK.players[id].get("arm_right")]
				true: match(e.NETWORK.players[id].get("height")):
					0: arm_right.texture = arms_right_short_chub[e.NETWORK.players[id].get("arm_right")]
					1: arm_right.texture = arms_right_average_chub[e.NETWORK.players[id].get("arm_right")]
					2: arm_right.texture = arms_right_tall_chub[e.NETWORK.players[id].get("arm_right")]
