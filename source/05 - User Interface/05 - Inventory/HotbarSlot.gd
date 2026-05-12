extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Integers
var quantity: int = 0
#Booleans
var is_empty: bool = true
#Strings
var contents: String
#Resources
var held_item: Object = null
#OnReady Variables
@onready var hotbar: PanelContainer = $"../.."
#Slot Nodes
@onready var texture_object: TextureRect = $Texture_Object
@onready var line_quantity: LineEdit = $LineEdit_Quantity
#------------------------------------------------------------------------------#
func _process(_delta: float) -> void:
	if is_empty == true: contents = "Empty"
	else:
		contents = held_item.name
		line_quantity.set_deferred("visible", held_item.is_stackable)
		line_quantity.text = str(quantity)


func _on_mouse_entered() -> void:
	hotbar.scroll_hotbar(name)
