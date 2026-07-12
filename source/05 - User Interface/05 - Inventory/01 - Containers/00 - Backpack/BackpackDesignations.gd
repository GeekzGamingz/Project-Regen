extends Control
#------------------------------------------------------------------------------#
#Constants
const BACKPACK_SMALL_BASE = preload("res://assets/00 - UserInterface/04 - Inventory/01 - Backpack/backpack_small_base.png")
const BACKPACK_SMALL_BASE_UPGRADE = preload("res://assets/00 - UserInterface/04 - Inventory/01 - Backpack/backpack_small_base_upgrade.png")
const BACKPACK_SLOT_AVAILABLE = preload("res://assets/00 - UserInterface/04 - Inventory/01 - Backpack/backpack_slot_available.png")
#------------------------------------------------------------------------------#
#Variables
#Enumerations
@export_enum("Mark I", "Mark II", "Mark III", "Mark IV", "Mark V") var designation
#OnReady Variables
@onready var b: PanelContainer = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Check Designation
func check_designation():
	check_switch()
	var sidepouch_a: Array = [b.slot_a1, b.slot_a2, b.slot_a3]
	var sidepouch_b: Array = [b.slot_b1, b.slot_b2, b.slot_b3]
	show_slot(sidepouch_a, false)
	show_slot(sidepouch_b, false)
	b.base_texture.texture = BACKPACK_SMALL_BASE
	match(designation):
		null: b.set_deferred("visible", false)
		0: #Mark I
			b.front_compartments.set_deferred("visible", true)
			b.front_left.set_deferred("visible", true)
			b.front_margin1.set_deferred("visible", true)
		1: #Mark II
			b.base.set_deferred("visible", true) 
			show_slot(sidepouch_a, false)
			show_slot(sidepouch_b, false)
		2: #Mark III
			b.base.set_deferred("visible", true)
			b.front_left.set_deferred("visible", true)
			b.front_compartments.set_deferred("visible", true)
			show_slot(sidepouch_a, false)
			show_slot(sidepouch_b, false)
		3: #Mark IV
			b.front_left.set_deferred("visible", true)
			b.front_compartments.set_deferred("visible", true)
			b.base.set_deferred("visible", true)
			b.base_texture.texture = BACKPACK_SMALL_BASE_UPGRADE
			show_slot(sidepouch_a, true)
			show_slot(sidepouch_b, true)
		4: #Mark V
			b.front_left.set_deferred("visible", true)
			b.front_right.set_deferred("visible", true)
			b.front_margin1.set_deferred("visible", true)
			b.front_margin2.set_deferred("visible", true)
			b.front_compartments.set_deferred("visible", true)
			b.base.set_deferred("visible", true)
			b.base_texture.texture = BACKPACK_SMALL_BASE_UPGRADE
			show_slot(sidepouch_a, true)
			show_slot(sidepouch_b, true)
#Check Switch
func check_switch():
	b.front_compartments.set_deferred("visible", false)
	b.front_left.set_deferred("visible", false)
	b.front_right.set_deferred("visible", false)
	b.front_margin1.set_deferred("visible", false)
	b.front_margin2.set_deferred("visible", false)
	b.base.set_deferred("visible", false)
#Slot Toggle
func show_slot(container, shown):
	var value = 1.0 if shown else 0.0
	for slot in container:
		slot.modulate = Color(1.0, 1.0, 1.0, value)
		slot.texture = BACKPACK_SLOT_AVAILABLE if shown else null
		slot.area.get_node("CollisionShape2D").set_deferred("disabled", !shown)
