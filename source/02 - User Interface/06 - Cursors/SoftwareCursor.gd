extends Node2D
#------------------------------------------------------------------------------#
#Variables
var old_state: String
#Exported Variables
#Exported Enumerations
@export_enum(
	"Default",
	"HandGrab",
	"HandOpen"
) var icon_state: String = "Default"
#OnReady Variables
#Local Nodes
@onready var cursor: Sprite2D = $Cursor
@onready var icon: Sprite2D = $CursorIcon
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if old_state != icon_state:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		match(icon_state):
			"Default":
				cursor.visible = false
				icon.visible = false
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			"HandOpen":
				icon.texture = icon.CURSOR_HAND_OPEN_RIGHT
				icon.visible = true
	old_state = icon_state
