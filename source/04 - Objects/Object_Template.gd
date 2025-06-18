extends StaticBody2D
class_name Interactable
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Exported Bools
@export var obtainable: bool = false
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
#Signaled Functions
#Mouse Entered
func _on_mouse_entered() -> void:
	if obtainable == true: print("Switch Cursor")
#Mouse Exited
func _on_mouse_exited() -> void: print("Return Cursor")
#------------------------------------------------------------------------------#
#Custom Functions
func interact(): pass
