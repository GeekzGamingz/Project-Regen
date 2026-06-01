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
	backpack.backpack_front.set_deferred("visible", false)
	backpack.container_base.set_deferred("visible", false)
	backpack.container_left.set_deferred("visible", false)
	backpack.container_right.set_deferred("visible", false)
	backpack.slot_a1.texture = null
	backpack.slot_a2.texture = null
	backpack.slot_a3.texture = null
	backpack.slot_b1.texture = null
	backpack.slot_b2.texture = null
	backpack.slot_b3.texture = null
	match(designation):
		null: backpack.set_deferred("visible", false)
		0: backpack.backpack_front.set_deferred("visible", true)
		1: backpack.container_base.set_deferred("visible", true)
		2: 
			backpack.container_base.set_deferred("visible", true)
			backpack.backpack_front.set_deferred("visible", true)
		3:
			backpack.backpack_front.set_deferred("visible", true)
			backpack.container_base.set_deferred("visible", true)
			backpack.container_left.set_deferred("visible", true)
			backpack.slot_a1.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_a2.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_a3.texture = BACKPACK_SLOT_AVAILABLE
		4:
			backpack.backpack_front.set_deferred("visible", true)
			backpack.container_base.set_deferred("visible", true)
			backpack.container_left.set_deferred("visible", true)
			backpack.container_right.set_deferred("visible", true)
			backpack.slot_a1.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_a2.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_a3.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_b1.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_b2.texture = BACKPACK_SLOT_AVAILABLE
			backpack.slot_b3.texture = BACKPACK_SLOT_AVAILABLE
