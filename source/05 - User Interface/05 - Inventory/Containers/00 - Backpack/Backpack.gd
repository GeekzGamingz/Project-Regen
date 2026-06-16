extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
var mouse_hovering: bool = false
#Arrays
@export var compartment_array: Array[HBoxContainer]
#OnReady Variables
#Local Nodes
@onready var designation: Control = $Designation
#Front Compartments
@onready var compartments: VBoxContainer = $Compartments
@onready var front_compartments: HBoxContainer = $Compartments/FrontCompartments
@onready var front_left: HBoxContainer = $Compartments/FrontCompartments/FrontLeft
@onready var front_right: HBoxContainer = $Compartments/FrontCompartments/FrontRight
@onready var front_margin1: MarginContainer = $Compartments/FrontCompartments/MarginContainer
@onready var front_margin2: MarginContainer = $Compartments/FrontCompartments/MarginContainer2
@onready var grid_fLeft: GridContainer = $Compartments/FrontCompartments/FrontLeft/TextureRect/GridContainer
@onready var grid_fRight: GridContainer = $Compartments/FrontCompartments/FrontRight/TextureRect/GridContainer
#Base Compartment
@onready var base: HBoxContainer = $Compartments/BaseCompartment
@onready var base_left: VBoxContainer = $Compartments/BaseCompartment/BaseLeft
@onready var base_right: VBoxContainer = $Compartments/BaseCompartment/BaseRight
@onready var base_lSprite: TextureRect = $Compartments/BaseCompartment/BaseLeft/Backpack_SideA
@onready var base_rSprite: TextureRect = $Compartments/BaseCompartment/BaseRight/Backpack_SideB
@onready var grid_base: GridContainer = $Compartments/BaseCompartment/TextureRect/GridContainer
#Slots
@onready var slot_a1: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotA1
@onready var slot_b1: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotB1
@onready var slot_a2: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotA2
@onready var slot_b2: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotB2
@onready var slot_a3: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotA3
@onready var slot_b3: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/SlotB3
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
