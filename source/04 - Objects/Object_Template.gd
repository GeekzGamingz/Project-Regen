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
#Exported Booleans
@export var is_obtainable: bool = false
#Exported Enumerations
#Item Type
@export_enum(
	"Building",
	"Consumable",
	"Equipment",
	"Flora",
	"Ingredient",
	"Junk",
	"Material"
) var item_type: String
#Item Material
@export_enum(
	"Fabric",
	"Metal",
	"Organic",
	"Plastic",
	"Stone",
	"Wood"
) var item_material: String
#Exported Dictionaries
@export var item_components: Dictionary = {
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
