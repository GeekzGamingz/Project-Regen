extends Interactable
#------------------------------------------------------------------------------#
#Custom Functions
func interact():
	print("Obtained: ", name)
	print("Slot to Place Object: ", HOTBAR.hotbar_array[HOTBAR.hotbar_selection].name)
