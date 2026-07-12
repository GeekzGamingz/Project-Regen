extends TextureButton
@export var grid: GridContainer


func _on_button_up() -> void: stack_container()
func stack_container():
	print("#---Button Stack Initiated---#")
	print("Container Name: ", grid.get_node("../..").name)
	print("Container Grid: ", grid)
