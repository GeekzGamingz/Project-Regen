extends Node2D
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var sprite_arm_left: Sprite2D = $Sprite_ArmLeft
@onready var sprite_arm_right: Sprite2D = $Sprite_ArmRight
@onready var sprite_leg_left: Sprite2D = $Sprite_LegLeft
@onready var sprite_leg_right: Sprite2D = $Sprite_LegRight
#------------------------------------------------------------------------------#
#Custom Functions
#Switch Limbs
func switch_limbs(facing):
	match(facing):
		"Left": 
			move_child(sprite_arm_right, 3)
			move_child(sprite_arm_left, 4)
			move_child(sprite_leg_right, 5)
			move_child(sprite_leg_left, 6)
		"Right":
			move_child(sprite_arm_left, 3)
			move_child(sprite_arm_right, 4)
			move_child(sprite_leg_left, 5)
			move_child(sprite_leg_right, 6)
