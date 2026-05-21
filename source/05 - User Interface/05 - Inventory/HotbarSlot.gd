extends TextureRect
#------------------------------------------------------------------------------#
const HOTBAR_SLOT = preload("res://assets/00 - UserInterface/04 - Inventory/00 - Hotbar/hotbar_slot.png")
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
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var hotbar: PanelContainer = $"../.."
#Slot Nodes
@onready var texture_object: TextureRect = $Texture_Object
@onready var line_quantity: LineEdit = $LineEdit_Quantity
@onready var slot_held: NinePatchRect = $NPR_Held
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void:
	if is_empty == true:
		contents = "Empty"
		quantity = 0
		texture_object.texture = HOTBAR_SLOT
		line_quantity.set_deferred("visible", false)
	else:
		contents = held_item.name
		line_quantity.set_deferred("visible", held_item.is_stackable)
		line_quantity.text = str(quantity)
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: hotbar.scroll_hotbar(name)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if is_empty == false:
				var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).object_interaction
				interaction.addto_hand(held_item, self)
			print(name, " Contains: ", contents, "(", quantity,")")
#------------------------------------------------------------------------------#
