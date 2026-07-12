extends Control
#------------------------------------------------------------------------------#
#Custom Functions
#Slot Exlcusion
func slot_exclusion(excluded): # Used for Shape Grid
	for container in get_children(): if container.name != "Hotbar":
		for compartment in container.compartment_array:
			for slot in compartment.get_node("TextureRect/GridContainer").get_children():
				if slot is TextureRect: slot.area.get_node("CollisionShape2D").set_deferred("disabled", excluded)
	print("#-Finished Slot Exclusion [", excluded, "]-#")
