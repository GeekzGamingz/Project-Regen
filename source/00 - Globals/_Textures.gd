class_name SpriteTextures
extends Node2D
#------------------------------------------------------------------------------#
#Global Dictionaries
#Zone Textures
var ZONE: Dictionary = {
	"ZONE_16x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16.png"),
	"ZONE_16x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x32.png"),
	"ZONE_16x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x48.png"),
	"ZONE_16x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-16x64.png"),
	"ZONE_32x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32.png"),
	"ZONE_32x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x16.png"),
	"ZONE_32x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x48.png"),
	"ZONE_32x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-32x64.png"),
	"ZONE_48x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48.png"),
	"ZONE_48x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x16.png"),
	"ZONE_48x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x32.png"),
	"ZONE_48x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-48x64.png"),
	"ZONE_64x16": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x16.png"),
	"ZONE_64x32": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x32.png"),
	"ZONE_64x48": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64x48.png"),
	"ZONE_64x64": preload("res://assets/02 - Objects/00 - Buildings/00 - Templates/Template-64.png")
}
var TORSO: Dictionary = {
	"S_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/00 - Short/00 - Average/torso_short_average_nw.png"),
	"S_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/00 - Short/01 - Chub/torso_short_chub_nw.png"),
	"A_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/01 - Average/00 - Average/torso_average_average_nw.png"),
	"A_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/01 - Average/01 - Chub/torso_average_chub_nw.png"),
	"T_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/02 - Tall/00 - Average/torso_tall_average_nw.png"),
	"T_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/00 - Torso/02 - Tall/01 - Chub/torso_tall_chub_nw.png")
}
var ARM_L: Dictionary = {
	"S_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/00 - Short/00 - Average/arm_left_short_average_nw.png"),
	"S_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/00 - Short/01 - Chub/arm_left_short_chub_nw.png"),
	"A_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/01 - Average/00 - Average/arm_left_average_average_nw.png"),
	"A_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/01 - Average/01 - Chub/arm_left_average_chub_nw.png"),
	"T_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/02 - Tall/00 - Average/arm_left_tall_average_nw.png"),
	"T_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/01 - ArmLeft/02 - Tall/01 - Chub/arm_left_tall_chub_nw.png"),
}
var ARM_R: Dictionary = {
	"S_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/00 - Short/00 - Average/arm_right_short_average_nw.png"),
	"S_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/00 - Short/01 - Chub/arm_right_short_chub_nw.png"),
	"A_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/01 - Average/00 - Average/arm_right_average_average_nw.png"),
	"A_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/01 - Average/01 - Chub/arm_right_average_chub_nw.png"),
	"T_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/02 - Tall/00 - Average/arm_right_tall_average_nw.png"),
	"T_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/02 - ArmRight/02 - Tall/01 - Chub/arm_right_tall_chub_nw.png"),
}
var LEG_L: Dictionary = {
	"S_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/00 - Short/00 - Average/leg_left_short_average_nw.png"),
	"S_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/00 - Short/01 - Chub/leg_left_short_chub_nw.png"),
	"A_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/01 - Average/00 - Average/leg_left_average_average_nw.png"),
	"A_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/01 - Average/01 - Chub/leg_left_average_chub_nw.png"),
	"T_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/02 - Tall/00 - Average/leg_left_tall_average_nw.png"),
	"T_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/03 - LegLeft/02 - Tall/01 - Chub/leg_left_tall_chub_nw.png"),
}
var LEG_R: Dictionary = {
	"S_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/00 - Short/00 - Average/leg_right_short_average_nw.png"),
	"S_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/00 - Short/01 - Chub/leg_right_short_chub_nw.png"),
	"A_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/01 - Average/00 - Average/leg_right_average_average_nw.png"),
	"A_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/01 - Average/01 - Chub/leg_right_average_chub_nw.png"),
	"T_A_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/02 - Tall/00 - Average/leg_right_tall_average_nw.png"),
	"T_C_NW": preload("res://assets/03 - Entities/00 - Humanoid/00 - Body/04 - LegRight/02 - Tall/01 - Chub/leg_right_tall_chub_nw.png"),
}
