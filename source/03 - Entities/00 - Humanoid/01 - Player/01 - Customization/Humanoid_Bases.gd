extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
@onready var e: Entity = $"../../.."
@onready var entity_colors: Node2D = e.get_node("Scripts/Entity_Customization/Entity_Colors")
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	for player in e.get_parent().get_children():
		var base = player.get_node("Sprites/Sprites_Body/Sprite_Base")
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
#Save Skin Colors
func save_skin(color_id):
	var customize_type = "Skin"
	var id = multiplayer.get_unique_id()
	e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
#Save Eye Colors
func save_eyes(color_id, eyes_linked, lateral):
	var id = multiplayer.get_unique_id()
	match(lateral):
		"Eye1":
			var customize_type = "EyeRight"
			e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
			if eyes_linked:
				customize_type = "EyeLeft"
				e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
		"Eye2":
			var customize_type = "EyeLeft"
			e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
			if eyes_linked:
				customize_type = "EyeRight"
				e.player_serverinfo.update_info.rpc(id, customize_type, color_id)
