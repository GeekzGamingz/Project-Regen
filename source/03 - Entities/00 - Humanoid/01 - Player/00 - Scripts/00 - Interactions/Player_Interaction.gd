extends Node2D
#------------------------------------------------------------------------------#
#Variables
var current_object: Node2D = null
var hands_origin: TextureRect = null
var full_hotbar: bool = false
var full_hands: bool = false
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var ORPHANAGES_OBJECTS: Node2D = MAIN.get_node("World/Orphanages/Orphanage_Objects")
@onready var HOTBAR: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Hotbar")
@onready var BACKPACK: PanelContainer = MAIN.get_node("UserInterface/UI_FullRect/Inventory/Backpack")
#Local Nodes
@onready var player: CharacterBody2D = $"../.."
@onready var input: Node2D = $"../Player_Input"
@onready var interaction_objects: Node2D = $Interaction_Objects
@onready var interaction_hotbar: Node2D = $Interaction_Hotbar
@onready var interaction_backpack: Node2D = $Interaction_Backpack
#------------------------------------------------------------------------------#
#Functions
#Input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_confirm"): # Left Click
		if current_object != null:
			if !HOTBAR.mouse_hovering && !BACKPACK.mouse_hovering:
				interaction_objects.place(
					current_object,
					hands_origin,
					get_global_mouse_position()
				)
	if event.is_action_pressed("action_context"): # Right Click
		if current_object != null: interaction_objects.cancel(current_object, hands_origin)
	if event.is_action_pressed("hotbar_drop"): # Q Key
		if player.is_multiplayer_authority():
			var selected_slot = interaction_hotbar.check_selection()
			if selected_slot.slotted_object != null && !full_hands:
				interaction_objects.place(
					selected_slot.slotted_object,
					selected_slot,
					get_node("../..").marker_drop.global_position
				)
#------------------------------------------------------------------------------#
#Custom Functions
#Revert Hotbar
func revert(): # Revert Settings to Default
	MAIN.UI_CURSOR.icon_state = "Default"
	MAIN.UI_CURSOR.object_held = null
	MAIN.UI_CURSOR.quantity = 0
	full_hands = false
	current_object = null
	hands_origin = null
