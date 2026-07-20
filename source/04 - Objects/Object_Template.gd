extends StaticBody2D
class_name Interactable
#------------------------------------------------------------------------------#
#Signals
signal object_clicked
#------------------------------------------------------------------------------#
#Variables
#Booleans
var mouse_is_hovering: bool = false
#Exported Variables
@export var index_name: String = "Not Set"
#Exported Booleans
@export var is_obtainable: bool = false
@export var is_stackable: bool = false
#Exported Enumerations
#object Type
@export_enum(
	"Building",
	"Consumable",
	"Equipment",
	"Flora",
	"Ingredient",
	"Junk",
	"Material"
) var object_type: String
#object Material
@export_enum(
	"Fabric",
	"Metal",
	"Organic",
	"Plastic",
	"Stone",
	"Wood"
) var object_material: String
#Exported Dictionaries
@export var object_components: Dictionary = {
	"Bone": int(0),
	"Fabric": int(0),
	"Metal": int(0),
	"Plastic":int(0),
	"Stone": int(0),
	"Wood": int(0)
}
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var HOTBAR: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Hotbar")
#Local Nodes
@onready var sprite_hotbar: Sprite2D = $Sprites/Sprite_Hotbar
@onready var sprite_preview: Sprite2D = $Sprites/Sprite_Preview
@onready var area_pack: CollisionPolygon2D = $Areas/Area_Pack/CollisionPolygon2D
#------------------------------------------------------------------------------#
#Functions
#Ready Function
func _ready() -> void:
	if is_obtainable: $Sprites/Sprite_Object.set_deferred("visible", true)
#------------------------------------------------------------------------------#
#Input Function
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_confirm"):
		if mouse_is_hovering: MAIN.UI_CURSOR.icon_state = "HandGrab"
	if event.is_action_released("action_confirm"):
		if mouse_is_hovering:
			MAIN.UI_CURSOR.icon_state = "HandOpen"
			emit_signal("object_clicked")
#------------------------------------------------------------------------------#
#Signaled Functions
#Mouse Entered
func _on_mouse_entered() -> void:
	mouse_is_hovering = true
	if is_obtainable: MAIN.UI_CURSOR.icon_state = "HandOpen"
#Mouse Exited
func _on_mouse_exited() -> void:
	mouse_is_hovering = false
	MAIN.UI_CURSOR.icon_state = "Default"
#------------------------------------------------------------------------------#
#Custom Functions
func interact(): pass
