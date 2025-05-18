extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
@export var beards_short: Array[Resource] = []
@export var beards_average: Array[Resource] = []
@export var beards_tall: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var entity_colors: Node2D = $"../../Scripts/Entity_Customization/Entity_Colors"
#------------------------------------------------------------------------------#
#Custom Functions
func check_beard():
	for player in e.get_parent().get_children():
		var beard = player.get_node("Sprites/Sprite_Beard")
		for id in e.NETWORK.players: if player.name == str(id):
			match(e.NETWORK.players[id].get("height")):
				0: beard.texture = beards_short[e.NETWORK.players[id].get("beard")]
				1: beard.texture = beards_average[e.NETWORK.players[id].get("beard")]
				2: beard.texture = beards_tall[e.NETWORK.players[id].get("beard")]
func color_beard(
	color_id, sprite, hair_linked, #Identifiers
	new_outline1, new_shadow1, new_base1, new_highlight1, #Color One
):
	entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
	if hair_linked:
		entity_colors.sprite_ears.material.set("shader_parameter/new_outline2", new_outline1)
		entity_colors.sprite_ears.material.set("shader_parameter/new_shadow2", new_shadow1)
		entity_colors.sprite_ears.material.set("shader_parameter/new_base2", new_base1)
		entity_colors.sprite_ears.material.set("shader_parameter/new_highlight2", new_highlight1)
		sprite = entity_colors.sprite_hair
		entity_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
