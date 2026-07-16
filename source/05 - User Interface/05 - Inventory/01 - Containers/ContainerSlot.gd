extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Bools
var mouse_hovering: bool = false
#Resources
var slot_primary: Object = null
var slotted_object: Object = null
#Exported Variables
#Integers
@export var quantity: int = 0
#Bools
@export var slot_occupied: bool = false
@export var slot_blocked: bool = false
#Strings
@export var contents: String = "Empty"
#Arrays
@export var slot_array: Array = [self]
#Nodes
@export var main_container: PanelContainer
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var axis: Node2D = $Axis
@onready var texture_object: TextureRect = $Axis/Texture_Object
@onready var slot_held: NinePatchRect = $NPR_Held
@onready var line_quantity: LineEdit = $LineEdit_Quantity
@onready var area: Area2D = $Area_Slot
#------------------------------------------------------------------------------#
func _process(_delta: float) -> void: line_quantity.text = str(quantity)
#Ready
func _ready() -> void: 
	await get_tree().process_frame
	MAIN.UI_CURSOR_FSM.connect("holding_object", slot_blocking)
	MAIN.UI_CURSOR.object.connect("grid_shaped", orient_held)
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
		if slotted_object != null && !interaction.full_hands:
			if event.is_action_pressed("hotbar_grabone"): # Crtl + Left Click
				MAIN.UI_INVENTORY.slot_exclusion(true)
				interaction.interaction_objects.addto_hand("One", slotted_object, self)
				await get_tree().process_frame
				MAIN.UI_INVENTORY.slot_exclusion(false)
			elif event.is_action_pressed("hotbar_grabhalf"): # Shft + Left Click
				MAIN.UI_INVENTORY.slot_exclusion(true)
				interaction.interaction_objects.addto_hand("Half", slotted_object, self)
				await get_tree().process_frame
				MAIN.UI_INVENTORY.slot_exclusion(false)
			elif event.is_action_pressed("action_confirm"): # Left-Click
				MAIN.UI_INVENTORY.slot_exclusion(true)
				interaction.interaction_objects.addto_hand("All", slotted_object, self)
				await get_tree().process_frame
				MAIN.UI_INVENTORY.slot_exclusion(false)
			elif event.is_action_pressed("action_context"):
				print("#---[", self.name, "] Contains---#")
				print("Held Object: ", slotted_object.name)
				print("Primary Slot: ", slot_primary)
				print("Associated Slots: ", slot_array)
				print("Rotation: ", axis.rotation_degrees, "°")
				print("Scale: ", axis.scale)
				print("Quantity: ", quantity)
		elif slotted_object == null:
			if interaction.current_object != null: interaction.interaction_containers.trade_slots(contents)
#------------------------------------------------------------------------------#
#Signaled Functions
#Slot Entered/Exited
func _on_slot_entered() -> void: mouse_hovering = true
func _on_slot_exited() -> void: mouse_hovering = false
#------------------------------------------------------------------------------#
#Custom Functions
#Highlight Object
func object_highlight(shown): for slot in slot_array: slot.slot_held.set_deferred("visible", shown)
#Slot Blocking
func slot_blocking(blocking):
	for slot in get_parent().get_children(): if slot is TextureRect:
		slot.slot_blocked = blocking
#Update Slot
func update_slot():
	contents = "Full"
	for slot in slot_array: slot.line_quantity.text = str(quantity)
	if slotted_object != null: if slot_primary == self:
		line_quantity.set_deferred("visible", slotted_object.is_stackable)
	slot_held.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
#Clear Slot
@rpc("any_peer", "call_local")
func clear_slot():
	var array: Array = []
	if main_container.name == "Backpack": array = slot_array
	else:
		var slot_index: String = str(name)
		var server_array = Items.CONTAINERS[main_container.name].get(slot_index).slot_array
		array = server_array
	for slot in array:
		slot.quantity = 0
		slot.contents = "Empty"
		slot.slot_occupied = false
		slot.slot_blocked = false
		slot.slot_primary = null
		slot.slotted_object = null
		slot.texture_object.texture = null
		slot.slot_held.set_deferred("visible", false)
		slot.line_quantity.set_deferred("visible", false)
		slot.slot_held.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
		slot.slot_array = [self]
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func orient_held(): 
	var cursor = MAIN.UI_CURSOR
	if slot_held.visible: 
		print("#-Signal Received: Grid Shaped-#")
		print("Slot Receiving: ", self.name)
		print("Slot Rotation: " , axis.rotation_degrees, "°")
		print("Slot Scale: ", axis.scale)
		print("Cursor Rotation: ", cursor.axis.rotation_degrees, "°")
		print("Cursor Scale: ", cursor.axis.scale)
		cursor.axis.rotation_degrees = axis.rotation_degrees
		cursor.axis.scale = axis.scale
		print("#-!Cursor Oriented!-#")
