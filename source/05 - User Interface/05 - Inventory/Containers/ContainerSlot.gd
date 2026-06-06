extends TextureRect
#------------------------------------------------------------------------------#
#Variables
#Integers
var quantity: int = 0
#Bools
var mouse_hovering: bool = false
var slot_occupied: bool = false
#Resources
var slotted_object: Object = null
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var selection_held: NinePatchRect = $NPR_Held
@onready var area: Area2D = $Area_Slot
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void: update_slot()
#GUI Input
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
		if slotted_object != null: pass
		elif interaction.current_object != null:
			if event.is_action_pressed("action_confirm"): interaction.interaction_containers.trade_slots("Empty")


#COPIED FROM HOTBAR
#GUI Input
#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion: hotbar.scroll_hotbar(name)
	#if event is InputEventMouseButton:
		#var interaction = MAIN.ORPHANAGE_PLAYERS.get_child(0).interaction
		#if slotted_object != null:
			#if event.is_action_pressed("hotbar_grabone"): # Crtl + Left Click
				#if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				#else: interaction.interaction_objects.addto_hand("One", slotted_object, self)
			#elif event.is_action_pressed("hotbar_grabhalf"): # Shft + Left Click
				#if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				#else: interaction.interaction_objects.addto_hand("Half", slotted_object, self)
			#elif event.is_action_pressed("action_confirm"): # Left Click
				#if interaction.full_hands: interaction.interaction_hotbar.trade_slots("Full")
				#else: interaction.interaction_objects.addto_hand("All", slotted_object, self)
		#elif interaction.current_object != null: interaction.interaction_hotbar.trade_slots("Empty")
		#if slotted_object != null:
			#print(name, " Contains: ", slotted_object.name, "(", quantity,")")
#------------------------------------------------------------------------------#
#Signaled Functions
#Slot Entered
func _on_slot_entered() -> void:
	mouse_hovering = true
	selection_held.set_deferred("visible", true)
	print("Entered Backpack Slot: ", name)
#Slot Exited
func _on_slot_exited() -> void:
	mouse_hovering = false
	selection_held.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Functions
#Update Slot
func update_slot():
	if !slot_occupied: selection_held.self_modulate = Color(0.0, 1.0, 0.0, 1.0)
	else: selection_held.self_modulate = Color(1.0, 0.0, 0.0, 1.0)
	
