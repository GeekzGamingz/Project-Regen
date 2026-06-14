extends Node2D
#------------------------------------------------------------------------------#
#Variables
var slot_array: Array = []
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Add to Backpack
func addto_backpack(object, slot, origin):
	slot.texture_object.texture = object.sprite_container.texture
	var object_scene = object.duplicate()
	slot.slotted_object = object_scene
	if origin != null:
		origin.slot_held.set_deferred("visible", false)
	print("Added ", object.name, " to Container")
#Trade Slots
func trade_slots(contents):
	if check_grid():
		var object = interaction.current_object
		var cursor = interaction.MAIN.UI_CURSOR
		var cursor_object = interaction.MAIN.UI_CURSOR_OBJECT
		var cursor_grid = cursor_object.get_node("GridContainer")
		var ray_primary = cursor_grid.get_node("NPR_Selection/RayCast2D")
		var slot_primary = ray_primary.get_collider().get_node("..")
		var hotbar_origin = interaction.interaction_hotbar.check_held()
		var container_origin = get_held()
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
				print("Container Origin: ", container_origin)
				print("Hotbar Origin: ", hotbar_origin)
				if hotbar_origin != null:
					hotbar_origin.quantity -= cursor.quantity
					if hotbar_origin.quantity <= 0: hotbar_origin.slotted_object = null
					print("Object Origin: ", hotbar_origin.name)
				clear_held()
				addto_backpack(object, slot_primary, hotbar_origin)
				for slot in slot_array:
					slot.slotted_object = object
					slot.slot_array = slot_array
					slot.slot_occupied = true
					slot.slot_primary = slot_primary
				if container_origin != null:
					slot_primary.quantity = container_origin.quantity
				else: slot_primary.quantity = cursor.quantity
				for slot in slot_array: slot.quantity = slot.slot_primary.quantity
				slot_array = [] # Clears Array for Future Use
				cursor_object.revert_hand()
				interaction.revert()
			"Full":
				print("#---Container Trade Executed - Slot Occupied---#") #Currently Prevented
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
#Get Held Slot
func get_held():
	var inventory = interaction.MAIN.UI_INVENTORY
	for container in inventory.get_children(): if container.name != "Hotbar":
		for compartment in container.compartments.get_children():
			for s in compartment.get_node("TextureRect/GridContainer").get_children():
				if s is TextureRect: if s.slot_held.visible: return s.slot_primary
#Check Held Container
func clear_held():
	var front_grid = interaction.BACKPACK.front_grid
	var base_grid = interaction.BACKPACK.base_grid
	for slot in front_grid.get_children(): if slot is TextureRect:
		if slot.slot_held.visible: slot.slotted_object = null
	for slot in base_grid.get_children(): if slot is TextureRect:
		if slot.slot_held.visible: slot.slotted_object = null
