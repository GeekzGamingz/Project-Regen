extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Integers
var quantity: int = 0
#Bools
var mouse_hovering: bool = false
var slot_occupied: bool = false
#Strings
var contents: String
#Arrays
var slot_array: Array = []
#Resources
var slotted_object: Object = null
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var texture_object: TextureRect = $Texture_Object
@onready var slot_held: NinePatchRect = $NPR_Held
@onready var line_quantity: LineEdit = $LineEdit_Quantity
@onready var area: Area2D = $Area_Slot
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void: update_slot()
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
		if event.is_action_pressed("action_confirm"): # Left-Click
			if interaction.current_object != null:
				if slotted_object == null: interaction.interaction_containers.trade_slots(contents)
			elif slotted_object != null:
				print("#---[", self.name, "] Contains---#")
				print("Held Object: ", slotted_object.name)
				print("Associated Slots: ", slot_array)
				print("Quantity: ", quantity)
				object_highlight(true)
				slot_exclusion(true)
				interaction.interaction_objects.addto_hand("All", slotted_object, self)
				await get_tree().process_frame
				slot_exclusion(false)
#------------------------------------------------------------------------------#
#Signaled Functions
#Slot Entered
func _on_slot_entered() -> void: mouse_hovering = true
#Slot Exited
func _on_slot_exited() -> void: mouse_hovering = false
#------------------------------------------------------------------------------#
#Custom Functions
#Highlight Object
func object_highlight(shown):
	slot_held.set_deferred("visible", shown)
	for slot in slot_array: slot.slot_held.set_deferred("visible", shown)
#Slot Exlcusion
func slot_exclusion(excluded): # Used for Shape Grid
	if excluded: for slot in get_parent().get_children():
		if slot is TextureRect: slot.area.get_node("CollisionShape2D").set_deferred("disabled", true)
	if !excluded: for slot in get_parent().get_children():
		if slot is TextureRect: slot.area.get_node("CollisionShape2D").set_deferred("disabled", false)
#Update Slot
func update_slot():
	if !slot_occupied: slot_held.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
	else: slot_held.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
	if slotted_object == null:
		if slot_array != []: for slot in slot_array:
			slot.contents = "Empty"
			slot.slotted_object = null
			slot.slot_occupied = false
			slot.quantity = 0
			slot.texture_object.texture = null
			slot.slot_held.set_deferred("visible", false)
			slot.line_quantity.set_deferred("visible", false)
			slot.slot_array = []
		else: if !slot_array.has(self): slot_array.append(self)
	else:
		contents = slotted_object.name
		line_quantity.set_deferred("visible", slotted_object.is_stackable)
		line_quantity.text = str(quantity)
