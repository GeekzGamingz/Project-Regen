extends HBoxContainer
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Local Nodes
@onready var selection_character: HBoxContainer = $"../Selection_Character"
@onready var sprites_character: Node2D = $"../Selection_Character/SubviewportContainer/SubViewport/Sprites_Character"
#Buttons
@onready var button_new: Button = $Button_New
@onready var button_save: Button = $Button_Save
@onready var button_edit: Button = $Button_Edit
@onready var button_delete: Button = $Button_Delete
