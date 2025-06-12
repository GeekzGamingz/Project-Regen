extends StaticBody2D
class_name Interactable
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Exported Bools
@export var obtainable: bool = false
#Exported Enumerations
@export_enum(
	"Building",
	"Consumable",
	"Equipment",
	"Flora",
	"Ingredient",
	"Junk",
	"Material"
) var item_type: String
@export_enum(
	"Fabric",
	"Metal",
	"Plastic",
	"Stone",
	"Wood"
) var item_material: String
#Exported Dictionaries
@export var item_components: Dictionary = {
	"Fabric": 0,
	"Metal": 0,
	"Plastic": 0,
	"Stone": 0,
	"Wood": 0
}
#------------------------------------------------------------------------------#
#Custom Functions
func interact(): pass
