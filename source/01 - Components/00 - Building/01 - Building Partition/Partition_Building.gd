extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Arrays
var zones: Array[Sprite2D] = []
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: assign_textures()
#------------------------------------------------------------------------------#
#Custom Functions
func assign_textures() -> void:
	for texture in G.ZONE_TEXTURES:
		var zone_sprite = Sprite2D.new()
		zone_sprite.texture = G.ZONE_TEXTURES[texture]
		zones.append(zone_sprite)
		add_child(zone_sprite)
