@icon("uid://bg2lm15tg20gg")
class_name SteamAchievementIcon3D
extends Sprite3D
## A Steam achievement icon node.
##
## A custom Sprite3D node used to fetch and display a Steam achievement icon based on the API name
## that is set.
##
## @tutorial(GodotSteamKit achievement icon tutorial): https://godotsteam.com/tutorials/godotsteamkit/achievement_icons

## The API name for this achievement in the Steamworks back-end.
@export var achievement_api_name: String = "" : set = set_api_name
## Set a specific size for the Steam achievement icon. Make sure this is smaller than the original
## image you uploaded to the Steamworks back-end.
@export var custom_size: int = 0

# The handle used to generate the image from.
var _icon_handle: int = 0 : set = _set_icon_handle


func _load_icon_image() -> void:
	var icon_size: Dictionary = Steam.getImageSize(_icon_handle)
	var icon_buffer: Dictionary = Steam.getImageRGBA(_icon_handle)
	if not icon_buffer['success']:
		printerr("Failed to get Steam achievement %s icon" % achievement_api_name)
		return

	var icon_image: Image = Image.create_from_data(icon_size['width'], icon_size['height'], false, Image.FORMAT_RGBA8, icon_buffer['buffer'])
	if custom_size > 0:
		icon_image.resize(custom_size, custom_size, Image.INTERPOLATE_LANCZOS)
	var icon_texture: ImageTexture = ImageTexture.create_from_image(icon_image)
	texture = icon_texture


## Sets the API name to pull the icon handle.
func set_api_name(new_achievement_api_name: String) -> void:
	achievement_api_name = new_achievement_api_name
	if not is_node_ready(): await ready
	if not achievement_api_name.is_empty():
		_icon_handle = Steam.getAchievementIcon(achievement_api_name)


func _set_icon_handle(new_handle: int) -> void:
	_icon_handle = new_handle
	if _icon_handle > 0:
		_load_icon_image()
