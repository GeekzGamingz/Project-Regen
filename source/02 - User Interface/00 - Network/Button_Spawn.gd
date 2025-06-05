extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal spawn_requested
@onready var splash_screen: Control = $"../../../../.."
@onready var customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Signaled Functions
#On Button Up
func _on_button_up() -> void:
	emit_signal("spawn_requested")
	hide_splash.rpc()
#------------------------------------------------------------------------------#
#RPC Functions
@rpc("any_peer", "call_local")
func hide_splash():
	splash_screen.set_deferred("visible", false)
	customization.set_deferred("visible", true)
