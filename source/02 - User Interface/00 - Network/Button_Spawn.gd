extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal spawn_requested
#------------------------------------------------------------------------------#
#Signaled Functions
#On Button Up
func _on_button_up() -> void:
	emit_signal("spawn_requested")
	set_deferred("visible", false)
