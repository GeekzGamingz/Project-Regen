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
@onready var base_texture: TextureRect = $Compartments/BaseCompartment/TextureRect
@onready var grid_base: GridContainer = $Compartments/BaseCompartment/TextureRect/GridContainer
#Slots
@onready var slot_a1: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot19
@onready var slot_b1: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot24
@onready var slot_a2: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot25
@onready var slot_b2: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot30
@onready var slot_a3: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot31
@onready var slot_b3: TextureRect = $Compartments/BaseCompartment/TextureRect/GridContainer/Slot36
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready():
	designation.check_designation()
	addto_dictionary()
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
#------------------------------------------------------------------------------#
#Custom Functions
func addto_dictionary():
	var slot_count = 0
	for compartment in compartment_array:
		for slot in compartment.get_node("TextureRect/GridContainer").get_children():
			if slot is TextureRect:
				slot_count += 1
				Items.SLOTS.set("Slot%s" % slot_count, slot)
	Items.CONTAINERS.set(name, Items.SLOTS.duplicate())
	Items.SLOTS.clear()
