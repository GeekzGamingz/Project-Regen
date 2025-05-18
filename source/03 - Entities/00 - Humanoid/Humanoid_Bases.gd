extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../.."
@onready var custom_colors: Node2D = $"../../Scripts/Entity_Customization/Entity_Colors"
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	for player in e.get_parent().get_children():
		var base = player.get_node("Sprites/Sprite_Base")
		for id in e.NETWORK.players:
			#If Player is Average
			if !e.NETWORK.players[id].get("chub"): if player.name == str(id):
				base.texture = bases_average[e.NETWORK.players[id].get("height")]
			#If Player is Chubby
			if e.NETWORK.players[id].get("chub"): if player.name == str(id):
				base.texture = bases_chub[e.NETWORK.players[id].get("height")]
#Check Animations
func check_animation():
	for player in e.get_parent().get_children():
		for id in e.NETWORK.players: if player.name == str(id):
			var animation_list = e.sprite_player.get_animation_list()
			var anim_desired = animation_list.get(e.NETWORK.players[id].get("animation"))
			player.sprite_player.play(anim_desired)
#Check Colors
#Color Skin
func color_skin(
	sprite, #Identifiers
	new_outline1, new_shadow1, new_base1, new_highlight1, #Color One
):
	custom_colors.sprite_ears.material.set("shader_parameter/new_outline1", new_outline1)
	custom_colors.sprite_ears.material.set("shader_parameter/new_shadow1", new_shadow1)
	custom_colors.sprite_ears.material.set("shader_parameter/new_base1", new_base1)
	custom_colors.sprite_ears.material.set("shader_parameter/new_highlight1", new_highlight1)
	custom_colors.update_primary(sprite, new_outline1, new_shadow1, new_base1, new_highlight1)
#Color Eyes
func color_eyes(
	sprite, eyes_linked, lateral, #Identifiers
	new_shadow2, new_highlight2, #Color Two
):
	match(lateral):
		"Eye1":
			sprite.material.set("shader_parameter/new_shadow2", new_shadow2)
			sprite.material.set("shader_parameter/new_highlight2", new_highlight2)
			if eyes_linked:
				sprite.material.set("shader_parameter/new_shadow3", new_shadow2)
				sprite.material.set("shader_parameter/new_highlight3", new_highlight2)
		"Eye2":
			sprite.material.set("shader_parameter/new_shadow3", new_shadow2)
			sprite.material.set("shader_parameter/new_highlight3", new_highlight2)
			if eyes_linked:
				sprite.material.set("shader_parameter/new_shadow2", new_shadow2)
				sprite.material.set("shader_parameter/new_highlight2", new_highlight2)
