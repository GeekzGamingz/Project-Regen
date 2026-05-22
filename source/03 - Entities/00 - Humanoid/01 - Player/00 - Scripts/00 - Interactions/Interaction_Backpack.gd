extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var interaction: Node2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
#Add to Backpack
func addto_backpack(_object):
	interaction.full_hands = true
	#print("Added ", object.name, " to Backpack")
