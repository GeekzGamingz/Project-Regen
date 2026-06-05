extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
var mouse_hovering: bool = false
#OnReady Variables
#Local Nodes
@onready var backpack_front: TextureRect = $"VBoxContainer/Backpack_Front"
@onready var container_base: HBoxContainer = $"VBoxContainer/ContainerBase"
@onready var container_left: VBoxContainer = $"VBoxContainer/ContainerBase/ContainerLeft"
@onready var container_right: VBoxContainer = $"VBoxContainer/ContainerBase/ContainerRight"
@onready var designations: Control = $Designations
#Slots
@onready var grid: GridContainer = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer"
@onready var slot_a1: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA1"
@onready var slot_b1: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB1"
@onready var slot_a2: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA2"
@onready var slot_b2: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB2"
@onready var slot_a3: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotA3"
@onready var slot_b3: TextureRect = $"VBoxContainer/ContainerBase/Backpack_Base/GridContainer/SlotB3"
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready(): designations.check_designation()
#------------------------------------------------------------------------------#
#Input
func _input(event: InputEvent) -> void:
	if designations.designation != null:
		if event.is_action_pressed("menu_backpack"):
			visible = !visible
			designations.check_designation()
#------------------------------------------------------------------------------#
#Signaled Functions
#Close Button
func _on_close_button_up() -> void: set_deferred("visible", false)
#Mouse Detection
func _on_mouse_entered() -> void: mouse_hovering = true
func _on_mouse_exited() -> void: mouse_hovering = false
