@tool

extends SpriteTextures

@export_enum("Short", "Average", "Tall") var height: String = "Average":
	set(new_setting):
		height = new_setting
		update_sprites()
@export var is_chub: bool = false
@export var is_wheels: bool = false

func update_sprites():
	var body: Node2D = $"../../Sprites/Sprites_Body"
	var offset: float
	var offset_sprites: Array = [
		body.get_node("Sprite_Hair"),
		body.get_node("Sprite_Ears"),
		body.get_node("Sprite_Beard"),
		body.get_node("Sprite_Bangs")
	]
	match(height):
		"Short":
			body.get_node("Sprite_Base").texture = BODY_TEXTURES["S_A_NW"]
			offset = -14.0
		"Average":
			body.get_node("Sprite_Base").texture = BODY_TEXTURES["A_A_NW"]
			offset = -16.0
		"Tall":
			body.get_node("Sprite_Base").texture = BODY_TEXTURES["T_A_NW"]
			offset = -18.0
	for sprite in offset_sprites: sprite.offset.y = offset
