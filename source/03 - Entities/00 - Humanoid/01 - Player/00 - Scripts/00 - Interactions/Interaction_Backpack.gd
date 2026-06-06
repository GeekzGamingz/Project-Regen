extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Add to Backpack
func addto_backpack(object, slot):
	slot.slotted_object = null
	slot.texture_object.texture = object.sprite_container.texture
	var object_scene = object.duplicate()
	slot.slotted_object = object_scene
	print("Added ", object.name, " to Backpack")
	
#Trade Slots
func trade_slots(contents):
	var cursor_grid = interaction.MAIN.UI_CURSOR_OBJECT.get_node("GridContainer")
	for selection in cursor_grid.get_children():
		var ray = selection.get_node("RayCast2D")
		if ray.is_colliding(): print(ray.get_collider())
