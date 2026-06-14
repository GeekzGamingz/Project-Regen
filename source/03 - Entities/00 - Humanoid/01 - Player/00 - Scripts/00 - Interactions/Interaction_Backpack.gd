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
	slot.slotted_object = null
	slot.quantity -= interaction.MAIN.UI_CURSOR.quantity
	slot.texture_object.texture = object.sprite_container.texture
	var object_scene = object.duplicate()
	slot.slotted_object = object_scene
	if origin != null: origin.slot_held.set_deferred("visible", false)
	combine_slots(object, slot, origin)
	print("Added ", object.name, " to Container")
#Combine Container Items
func combine_slots(object, slot, origin):
	print("#---Combing Slots---#")
	print("Current Object: ", object)
	print("Current Container Slot: ", slot)
	var stack_origin = origin
	var stack_quantity = origin.quantity
	for s in slot.get_parent().get_children(): # Grabs Container
		if s is TextureRect: if s.contents == "Full": # Skips Margins/Empty Slots
			if s.slot_primary == s: if s.slotted_object != null: # Returns Matching Primaries
				if object.is_stackable && s.slotted_object.is_stackable: # Ignores Unstackables
					if s.slotted_object.get_groups()[0].contains(object.get_groups()[0]): # Matches Groups
						stack_origin = s
						stack_quantity = s.quantity
	await get_tree().process_frame
	if stack_origin != null:
		print("Found Match: ", stack_origin)
		print("Match Quantity: ", stack_quantity)
		print("Current Slot Quantity: ", slot.quantity)
		slot.quantity += stack_quantity
		slot.update_slot()
		stack_origin.slotted_object = null
		stack_origin.update_slot()
	else: print("stack is null")
	print("#---Finished Combining---#")
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
		var container_origin = get_held(slot_primary)
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
				var origin
				if hotbar_origin != null: origin = hotbar_origin
				elif container_origin != null: origin = container_origin
				origin.quantity -= cursor.quantity
				if origin.quantity <= 0: origin.slotted_object = null
				clear_held()
				addto_backpack(object, slot_primary, origin)
				for slot in slot_array:
					slot.slotted_object = object
					slot.slot_array = slot_array
					slot.slot_occupied = true
					slot.slot_primary = slot_primary
				slot_primary.quantity = cursor.quantity
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
#Get Held Container
func get_held(slot):
	for s in slot.get_parent().get_children(): if s is TextureRect:
		if s.slot_held.visible: return s.slot_primary
#Clear Held Container
func clear_held():
	var front_grid = interaction.BACKPACK.front_grid
	var base_grid = interaction.BACKPACK.base_grid
	for slot in front_grid.get_children(): if slot is TextureRect:
		if slot.slot_held.visible: slot.slotted_object = null
	for slot in base_grid.get_children(): if slot is TextureRect:
		if slot.slot_held.visible: slot.slotted_object = null
