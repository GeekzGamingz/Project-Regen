extends TextureRect
#------------------------------------------------------------------------------#
const HOTBAR_SLOT = preload("res://assets/00 - UserInterface/04 - Inventory/00 - Hotbar/hotbar_slot.png")
#------------------------------------------------------------------------------#
#Variables
#Integers
var quantity: int = 0
#Booleans
var is_empty: bool = true
var mouse_hovering: bool = false
#Strings
var contents: String
#Resources
var slotted_item: Object = null
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var hotbar: PanelContainer = $"../.."
#Slot Nodes
@onready var texture_object: TextureRect = $Texture_Object
@onready var line_quantity: LineEdit = $LineEdit_Quantity
@onready var slot_selected: NinePatchRect = $NPR_Selection
@onready var slot_held: NinePatchRect = $NPR_Held
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void: update_slot()
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		hotbar.scroll_hotbar(name)
	if event is InputEventMouseButton:
		if event.is_action_pressed("action_confirm"):
			var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
			if is_empty == false:
				if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				else: interaction.interaction_objects.addto_hand(slotted_item, self)
			elif interaction.current_object != null: interaction.interaction_hotbar.trade_slots("Empty")
			print(name, " Contains: ", contents, "(", quantity,")")
#------------------------------------------------------------------------------#
#Custom Functions
func update_slot():
	if is_empty == true:
		contents = "Empty"
		slotted_item = null
		quantity = 0
		texture_object.texture = HOTBAR_SLOT
		slot_held.set_deferred("visible", false)
		line_quantity.set_deferred("visible", false)
	else:
		contents = slotted_item.name
		line_quantity.set_deferred("visible", slotted_item.is_stackable)
		line_quantity.text = str(quantity)
