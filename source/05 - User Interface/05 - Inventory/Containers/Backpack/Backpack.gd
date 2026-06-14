extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
var mouse_hovering: bool = false
#OnReady Variables
#Local Nodes
@onready var compartments: VBoxContainer = $ContainerCompartment
@onready var backpack_front: TextureRect = $"ContainerCompartment/ContainerFront/TextureRect"
@onready var container_base: HBoxContainer = $"ContainerCompartment/ContainerBase"
@onready var container_left: VBoxContainer = $"ContainerCompartment/ContainerBase/ContainerLeft"
@onready var container_right: VBoxContainer = $"ContainerCompartment/ContainerBase/ContainerRight"
@onready var designation: Control = $Designation
#Slots
@onready var front_grid: GridContainer = $ContainerCompartment/ContainerFront/TextureRect/GridContainer
@onready var base_grid: GridContainer = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer"
@onready var slot_a1: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotA1"
@onready var slot_b1: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotB1"
@onready var slot_a2: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotA2"
@onready var slot_b2: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotB2"
@onready var slot_a3: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotA3"
@onready var slot_b3: TextureRect = $"ContainerCompartment/ContainerBase/TextureRect/GridContainer/SlotB3"
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready(): designation.check_designation()
#------------------------------------------------------------------------------#
#Input
func _input(event: InputEvent) -> void:
	if designation.designation != null:
		if event.is_action_pressed("menu_backpack"):
			visible = !visible
			designation.check_designation()
#------------------------------------------------------------------------------#
#Signaled Functions
#Close Button
func _on_close_button_up() -> void: set_deferred("visible", false)
#Mouse Detection
func _on_mouse_entered() -> void: mouse_hovering = true
func _on_mouse_exited() -> void: mouse_hovering = false
