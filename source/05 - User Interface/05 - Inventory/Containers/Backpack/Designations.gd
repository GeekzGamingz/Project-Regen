extends Control
#------------------------------------------------------------------------------#
#Constants
const BACKPACK_SLOT_AVAILABLE = preload("res://assets/00 - UserInterface/04 - Inventory/01 - Backpack/backpack_slot_available.png")
#------------------------------------------------------------------------------#
#Variables
#Enumerations
@export_enum("Mark I", "Mark II", "Mark III", "Mark IV", "Mark V") var designation
#OnReady Variables
@onready var backpack: PanelContainer = $".."
#------------------------------------------------------------------------------#
#Custom Functions
func check_designation():
	#Arrays
	var sidepouch_a: Array = [backpack.slot_a1, backpack.slot_a2, backpack.slot_a3]
	var sidepouch_b: Array = [backpack.slot_b1, backpack.slot_b2, backpack.slot_b3]
	backpack.backpack_front.set_deferred("visible", false)
	backpack.container_base.set_deferred("visible", false)
	backpack.container_left.set_deferred("visible", false)
	backpack.container_right.set_deferred("visible", false)
	show_slot(sidepouch_a, false)
	show_slot(sidepouch_b, false)
	match(designation):
		null: backpack.set_deferred("visible", false)
		0: backpack.backpack_front.set_deferred("visible", true) #Mark I
		1: backpack.container_base.set_deferred("visible", true) #Mark II
		2: #Mark III
			backpack.container_base.set_deferred("visible", true)
			backpack.backpack_front.set_deferred("visible", true)
		3: #Mark IV
			backpack.backpack_front.set_deferred("visible", true)
			backpack.container_base.set_deferred("visible", true)
			backpack.container_left.set_deferred("visible", true)
			show_slot(sidepouch_a, true)
		4: #Mark V
			backpack.backpack_front.set_deferred("visible", true)
			backpack.container_base.set_deferred("visible", true)
			backpack.container_left.set_deferred("visible", true)
			backpack.container_right.set_deferred("visible", true)
			show_slot(sidepouch_a, true)
			show_slot(sidepouch_b, true)
#Slot Toggle
func show_slot(container, shown):
	var value = 1.0 if shown else 0.0
	for slot in container:
		slot.modulate = Color(1.0, 1.0, 1.0, value)
		slot.texture = BACKPACK_SLOT_AVAILABLE if shown else null
		slot.area.get_node("CollisionShape2D").set_deferred("disabled", !shown)
