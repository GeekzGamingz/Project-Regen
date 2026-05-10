extends PanelContainer
#------------------------------------------------------------------------------#
#Constants
const BACKPACK_SLOT_AVAILABLE = preload("res://assets/00 - UserInterface/04 - Inventory/01 - Backpack/backpack_slot_available.png")
#------------------------------------------------------------------------------#
#Variables
#Enumerations
@export_enum("Mark I", "Mark II", "Mark III", "Mark IV") var designation
#OnReady Variables
@onready var backpack: PanelContainer = $"."
@onready var container_base: HBoxContainer = $VBoxContainer/ContainerBase
@onready var container_left: VBoxContainer = $VBoxContainer/ContainerBase/ContainerLeft
@onready var container_right: VBoxContainer = $VBoxContainer/ContainerBase/ContainerRight
@onready var slot_a1: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA1
@onready var slot_b1: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB1
@onready var slot_a2: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA2
@onready var slot_b2: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB2
@onready var slot_a3: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA3
@onready var slot_b3: TextureRect = $VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB3

#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready(): check_designation()
#------------------------------------------------------------------------------#
#Input
func _input(event: InputEvent) -> void:
	if designation != null:
		if event.is_action_pressed("menu_backpack"):
			backpack.visible = !backpack.visible
			check_designation()
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_close_button_up() -> void: backpack.set_deferred("visible", false)
#------------------------------------------------------------------------------#
#Custom Functions
func check_designation():
	match(designation):
		null: backpack.set_deferred("visible", false)
		0: container_base.set_deferred("visible", false)
		1: container_base.set_deferred("visible", true)
		2:
			container_left.set_deferred("visible", true)
			slot_a1.texture = BACKPACK_SLOT_AVAILABLE
			slot_a2.texture = BACKPACK_SLOT_AVAILABLE
			slot_a3.texture = BACKPACK_SLOT_AVAILABLE
		3:
			container_right.set_deferred("visible", true)
			slot_b1.texture = BACKPACK_SLOT_AVAILABLE
			slot_b2.texture = BACKPACK_SLOT_AVAILABLE
			slot_b3.texture = BACKPACK_SLOT_AVAILABLE
