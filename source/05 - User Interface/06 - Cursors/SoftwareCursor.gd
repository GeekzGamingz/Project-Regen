extends Node2D
#------------------------------------------------------------------------------#
#Variables
var quantity = 0
var object_held: StaticBody2D = null
#Exported Variables
#Exported Enumerations
@export_enum(
	"Default",
	"HandGrab",
	"HandOpen",
	"HoldObject"
) var icon_state: String = "Default"
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var cursor: Sprite2D = $Cursor_Textures/Cursor
@onready var icon: Sprite2D = $Cursor_Textures/CursorIcon
@onready var item: Sprite2D = $Cursor_Textures/CursorObject
@onready var item_area: CollisionPolygon2D = $Cursor_Textures/CursorObject/Area_Backpack/CollisionPolygon2D
@onready var output_quantity: LineEdit = $Outputs/Output_Quantity
@onready var cursor_fsm: Node2D = $Cursor_StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayers/AnimationPlayer
#------------------------------------------------------------------------------#
#Process Functions
func _process(_delta: float) -> void: global_position = get_global_mouse_position()
