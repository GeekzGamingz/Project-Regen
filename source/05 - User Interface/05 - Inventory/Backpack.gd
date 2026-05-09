extends PanelContainer

@onready var backpack: PanelContainer = $"."


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_backpack"): backpack.visible = !backpack.visible



func _on_close_button_up() -> void: backpack.set_deferred("visible", false)
