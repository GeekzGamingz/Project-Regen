extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Array
var slot_array: Array = []
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Add to Backpack
func addto_container(object, slot, origin, array):
	var held_index = object.index_name
	var container_index = slot.main_container.name
	var slot_index = str(slot.name)
	var index_array = []
	var cursor = interaction.MAIN.UI_CURSOR
	var quantity: int
	var native_origin: String
	if origin.name.begins_with("Hotbar"): native_origin = "Hotbar"
	elif origin.name.begins_with("Slot"):
		native_origin = "Container" if origin.main_container.name != "Backpack" else "Backpack"
	else: native_origin = "Ground"
	match(native_origin):
		"Container", "Backpack": quantity = origin.quantity
		_: quantity = cursor.quantity
	for i in array:
		var index = str(i.name)
		index_array.append(index)
	print("Container Index: ", container_index)
	print("Origin: ", origin)
	if slot.main_container.name == "Backpack": update_server_containers(
			held_index,
			container_index,
			slot_index,
			index_array,
			quantity
		)
	else: rpc("update_server_containers",
		held_index,
		container_index,
		slot_index,
		index_array,
		quantity
		)
	slot_orientation()
	if origin != null: origin.slot_held.set_deferred("visible", false)
	print("Added ", object.name, " to Container")
#Update Server Containers
@rpc("any_peer", "call_local")
func update_server_containers(held_index, container_index, slot_index, index_array, quantity):
	var object_scene = Items.SCENES.get(held_index).instantiate()
	var native_slot = Items.CONTAINERS[container_index].get(slot_index)
	var native_array = []
	for index in index_array:
		var slot = Items.CONTAINERS[container_index].get(index)
		native_array.append(slot)
	add_child(object_scene)
	native_slot.texture_object.texture = object_scene.sprite_container.texture
	for slot in native_array:
		slot.slot_occupied = true
		slot.slot_array = native_array
		slot.slot_primary = native_slot
		slot.slotted_object = object_scene
		slot.quantity = quantity
	remove_child(object_scene)
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
				clear_held(container_origin)
				var origin = hotbar_origin if hotbar_origin != null else container_origin
				addto_container(object, slot_primary, origin, slot_array)
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
		print(ray.get_collider())
	if container_count == cursor_grid.get_node("..").held_slots: return true
	else: return false
#Get Held Slot
func get_held():
	var inventory = interaction.MAIN.UI_INVENTORY
	for container in inventory.get_children(): if container.name != "Hotbar":
		for compartment in container.compartment_array:
			for s in compartment.get_node("TextureRect/GridContainer").get_children():
				if s is TextureRect: if s.slot_held.visible: return s.slot_primary
#Check Held Container
func clear_held(origin):
	if origin != null:
		if origin.slot_held.visible: origin.slotted_object = null
#Slot Orientation
func slot_orientation():
	var cursor = interaction.MAIN.UI_CURSOR
	if slot_array != []:
		for slot in slot_array:
			slot.axis.rotation_degrees = cursor.axis.rotation_degrees
			slot.axis.scale.x = cursor.axis.scale.x
