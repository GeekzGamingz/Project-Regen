extends Node2D
#------------------------------------------------------------------------------#
#Variables
var slot_array: Array = []
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
	if check_grid():
		var object = interaction.current_object
		var cursor_object = interaction.MAIN.UI_CURSOR_OBJECT
		var cursor_grid = cursor_object.get_node("GridContainer")
		var ray_primary = cursor_grid.get_node("NPR_Selection/RayCast2D")
		var slot_primary = ray_primary.get_collider().get_node("..")
		for selection in cursor_grid.get_children():
			if selection.get_node("RayCast2D").enabled:
				slot_array.append(selection.get_node("RayCast2D").get_collider().get_node(".."))
		match(contents):
			"Empty":
				print("#---Container Trade Executed - Slot Empty---#")
				print("Primary Raycast: ", ray_primary)
				print("Primary Slot: ", slot_primary)
				print("Held Object: ", object.name)
				print("Slot Array: ", slot_array)
				if interaction.interaction_hotbar.check_held() != null:
					interaction.interaction_hotbar.check_held().slotted_object = null
					print("Object Origin: ", interaction.interaction_hotbar.check_held().name)
				addto_backpack(object, slot_primary)
				for slot in slot_array:
					slot.slotted_object = object
					slot.slot_array = slot_array
					slot.slot_occupied = true
				slot_array = [] # Clears Array for Future Use
				
				cursor_object.revert_hand()
				interaction.revert()
			"Full":
				print("#---Container Trade Executed - Slot Occupied---#")
	else: print("#---Container Trade Attempted - Not Enough Space---#")
	print("#---Finished Container Trade---#")
#Check Cursor Grid
func check_grid() -> bool:
	var cursor_grid = interaction.MAIN.UI_CURSOR_OBJECT.get_node("GridContainer")
	var container_count: int = 0
	for selection in cursor_grid.get_children():
		var ray = selection.get_node("RayCast2D")
		if ray.is_colliding(): container_count += 1
	if container_count == cursor_grid.get_node("..").held_slots: return true
	else: return false
