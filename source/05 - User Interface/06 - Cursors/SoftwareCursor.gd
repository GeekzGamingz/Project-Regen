extends Node2D
#------------------------------------------------------------------------------#
#Variables
var old_state: String
var object_held: StaticBody2D = null
#Exported Variables
#Exported Enumerations
@export_enum(
	"Default",
	"HandGrab",
	"HandOpen"
) var icon_state: String = "Default"
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var cursor: Sprite2D = $Cursor
@onready var icon: Sprite2D = $CursorIcon
@onready var item: Sprite2D = $CursorObject
@onready var animation_player: AnimationPlayer = $AnimationPlayer
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
				item.visible = false
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			"HandOpen":
				icon.texture = icon.CURSOR_HAND_OPEN_RIGHT
				icon.visible = true
			"HandGrab":
				icon.texture = icon.CURSOR_HAND_GRAB_RIGHT
				icon.visible = true
			"HoldObject":
				icon.texture = icon.CURSOR_HAND_GRAB_RIGHT
				icon.visible = true
				add_child(object_held)
				item.texture = object_held.sprite_preview.texture
				item.visible = true
				remove_child(object_held)
	old_state = icon_state
