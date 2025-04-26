extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal send_dimensions
signal send_building
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var building: PackedScene
@export var is_unlocked: bool = false
#Exported Dictionaries
@export var dimensions: Dictionary = {
	"16x16": false,
	"16x32": false,
	"16x48": false,
	"16x64": false,
	"32x16": false,
	"32x32": false,
	"32x48": false,
	"32x64": false,
	"48x16": false,
	"48x32": false,
	"48x48": false,
	"48x64": false,
	"64x16": false,
	"64x32": false,
	"64x48": false,
	"64x64": false
}
#------------------------------------------------------------------------------#
#Signaled Functions
#Button Up
func _on_button_up() -> void:
	G.IS_BUILDING = true
	emit_signal("send_dimensions", dimensions)
	emit_signal("send_building", building)
#Mouse Entered
func _on_mouse_entered() -> void:
	if G.CAN_BUILD: G.CAN_BUILD = false
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
#Mouse Exited
func _on_mouse_exited() -> void:
	if !G.CAN_BUILD: G.CAN_BUILD = true
	else: G.CAN_BUILD = false
	if G.IS_BUILDING: Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
