extends Node2D
#------------------------------------------------------------------------------#
#Variables
var customize_type: String
#Integers
@export var ear_counter: int = 0
@export var arm_left_counter: int = 1
@export var arm_right_counter: int = 1
@export var leg_left_counter: int = 1
@export var leg_right_counter: int = 1
@export var hair_counter: int = 0
@export var beard_counter: int = 0
@export var anim_counter: int = 0
@export var anim_direction: int = 0
#Bools
@export var is_chub: bool = false
@export var is_wheels: bool = false
#Exported Variables
#Dictionaries
var old_sprite_info: Dictionary = {}
@export var sprite_info: Dictionary = {
	"profile": String(""),
	"height": int(1),
	"chub": bool(false),
	"wheelchair": bool(false),
	"arm_left": int(1),
	"arm_right": int(1),
	"leg_left": int(1), 
	"leg_right": int(1), 
	"ears": int(0),
	"eyeL_color": String("Button_Color1"),
	"eyeR_color": String("Button_Color1"),
	"skin_color": String("Button_Color1"),
	"hair": int(0),
	"hair_color": String("Button_Color1"),
	"bangs": int(0),
	"beard": int(0),
	"beard_color": String("Button_Color1")
}
#OnReady Variables
#Local Nodes
@onready var splash_screen: Control = $"../../../../../../../.."
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
@onready var sprite_player: AnimationPlayer = $AnimPlayer_Sprites
@onready var sprites_body: Node2D = $Sprites_Body
#Sprites
@onready var sprite_ears: Sprite2D = $Sprites_Body/Sprite_Ears
@onready var sprite_base: Sprite2D = $Sprites_Body/Sprite_Base
@onready var sprite_arm_right: Sprite2D = $Sprites_Body/Sprite_ArmRight
@onready var sprite_arm_left: Sprite2D = $Sprites_Body/Sprite_ArmLeft
@onready var sprite_leg_right: Sprite2D = $Sprites_Body/Sprite_LegRight
@onready var sprite_leg_left: Sprite2D = $Sprites_Body/Sprite_LegLeft
@onready var sprite_hair: Sprite2D = $Sprites_Hair/Sprite_Hair
@onready var sprite_beard: Sprite2D = $Sprites_Hair/Sprite_Beard
@onready var sprite_bangs: Sprite2D = $Sprites_Hair/Sprite_Bangs
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	#Connections
	ui_customization.connect("uic_chub_change", uic_chub_change)
	ui_customization.connect("uic_height_change", check_sprites)
	ui_customization.connect("uic_arm_left_change", check_sprites)
	ui_customization.connect("uic_arm_right_change", check_sprites)
	ui_customization.connect("uic_leg_left_change", check_sprites)
	ui_customization.connect("uic_leg_right_change", check_sprites)
	ui_customization.connect("uic_ear_change", check_sprites)
	ui_customization.connect("uic_hair_change", check_sprites)
	ui_customization.connect("uic_beard_change", check_sprites)
	ui_customization.connect("uic_animation_change", uic_animation_change)
#------------------------------------------------------------------------------#
#Process Function
func _process(_delta: float) -> void:
	if old_sprite_info != sprite_info:
		check_sprites("")
	old_sprite_info = sprite_info
#------------------------------------------------------------------------------#
#Signaled Functions
#Rotate Counter Clockwise
func _on_rotate_counter_button_up() -> void:
	anim_direction -= 1
	if anim_direction < 0: anim_direction = 3
	elif anim_direction == 4: anim_direction = 0
	check_animation()
#Rotate Clockwise
func _on_rotate_clockwise_button_up() -> void:
	anim_direction += 1
	if anim_direction < 0: anim_direction = 3
	elif anim_direction == 4: anim_direction = 0
	check_animation()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Check Sprites
func check_sprites(_scroll):
	sprite_base.check_base()
	sprite_ears.check_ears()
	sprite_hair.check_hair()
	sprite_beard.check_beard()
	sprite_arm_left.check_arm_left()
	sprite_arm_right.check_arm_right()
	sprite_leg_left.check_leg_left()
	sprite_leg_right.check_leg_right()
#Change Chub
func uic_chub_change(toggled_on):
	is_chub = toggled_on
	sprite_info["chub"] = toggled_on
	check_sprites(is_chub)
#Change Animation
func uic_animation_change(scroll):
	match(scroll):
		"Previous": anim_counter -= 1
		"Next": anim_counter += 1
	if anim_counter < 0: anim_counter = 1
	elif anim_counter == 2: anim_counter = 0
	check_animation()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Animations
func check_animation():
	match(anim_counter):
		0: match(anim_direction):
			0: sprite_player.play("still_down")
			1:
				sprites_body.switch_limbs("Left")
				sprite_player.play("still_left")
				
			2: sprite_player.play("still_up")
			3:
				sprites_body.switch_limbs("Right")
				sprite_player.play("still_right")
		1: match(anim_direction):
			0: sprite_player.play("walk_down")
			1:
				sprites_body.switch_limbs("Left")
				sprite_player.play("walk_left")
			2: sprite_player.play("walk_up")
			3:
				sprites_body.switch_limbs("Right")
				sprite_player.play("walk_right")
