extends Node
#------------------------------------------------------------------------------#
#Constants
#Default
const CURSOR_DEFAULT = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_default.png")
#Cursors
const CURSOR_ACTIVATE = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_activate.png")
const CURSOR_DEACTIVATE = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_deactivate.png")
const CURSOR_ADD = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_add.png")
const CURSOR_INQUIRE = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_inquire.png")
const CURSOR_QWEST = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_qwest.png")
#Hands
const CURSOR_HAND_GRAB_LEFT = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_hand_grab_left.png")
const CURSOR_HAND_GRAB_RIGHT = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_hand_grab_right.png")
const CURSOR_HAND_OPEN_LEFT = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_hand_open_left.png")
const CURSOR_HAND_OPEN_RIGHT = preload("res://assets/00 - UserInterface/05 - Cursors/cursor_hand_open_right.png")
#------------------------------------------------------------------------------#
#Variables
#Strings
var old_state: String
#Vectors
var cursor_size_base: Vector2 = Vector2(16, 16)
#Exported Variables
#Exported Enumerations
@export_enum(
	"Default",
	"HandOpen",
	"HandGrab"
) var CURSOR_STATE: String = "Default"
#OnReady Variables
#OnReady Vectors
@onready var window_size_base: Vector2 = get_window().size
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	$"/root".set_script(load("res://source/00 - Globals/_CursorsNotifier.gd"))
	resize_cursor()
#------------------------------------------------------------------------------#
#Process Function
func _process(_delta: float) -> void:
	if old_state != CURSOR_STATE:
		match(CURSOR_STATE):
			"Default": Input.set_custom_mouse_cursor(CURSOR_DEFAULT)
			"HandOpen": Input.set_custom_mouse_cursor(CURSOR_HAND_OPEN_LEFT)
			"HandGrab": Input.set_custom_mouse_cursor(CURSOR_HAND_GRAB_LEFT)
	old_state = CURSOR_STATE
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Resize Cursor
func resize_cursor():
	var window_size = get_window().size
	var scale = min(
		snapped(window_size.x / window_size_base.x, 0.01),
		snapped(window_size.y / window_size_base.y, 0.01)
	)
	var image = CURSOR_DEFAULT.get_image()
	image.resize(cursor_size_base.x * scale, cursor_size_base.y * scale, Image.INTERPOLATE_NEAREST)
	ImageTexture.create_from_image(image)
	Input.set_custom_mouse_cursor(image)
