extends TextureRect
#------------------------------------------------------------------------------#
const HOTBAR_SLOT = preload("res://assets/00 - UserInterface/04 - Inventory/00 - Hotbar/hotbar_slot.png")
#------------------------------------------------------------------------------#
#Variables
#Integers
var quantity: int = 0
#Booleans
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
	if event is InputEventMouseMotion: hotbar.scroll_hotbar(name)
	if event is InputEventMouseButton:
		var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
		if slotted_item != null:
			if event.is_action_pressed("hotbar_grabone"):
				if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				else: interaction.interaction_objects.addto_hand("One", slotted_item, self)
				print("Grabbed One")
			elif event.is_action_pressed("hotbar_grabhalf"):
				if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				else: interaction.interaction_objects.addto_hand("Half", slotted_item, self)
				print("Grabbed Half")
			elif event.is_action_pressed("action_confirm"):
				if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				else: interaction.interaction_objects.addto_hand("All", slotted_item, self)
				print("Grabbed All")
		elif interaction.current_object != null: interaction.interaction_hotbar.trade_slots("Empty")
		if slotted_item != null:
			print(name, " Contains: ", slotted_item.name, "(", quantity,")")
#------------------------------------------------------------------------------#
#Custom Functions
func update_slot():
	if slotted_item == null:
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
