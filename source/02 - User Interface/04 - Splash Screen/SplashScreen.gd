extends Control
#------------------------------------------------------------------------------#
#Variables
#OnReady Variabels
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
@onready var NETWORK: Node2D = MAIN.get_node("Network")
#Local Nodes
#Tabs
@onready var sub_menus: TabContainer = $HBoxContainer/SubMenus
@onready var tab_singleplayer: VBoxContainer = $HBoxContainer/SubMenus/SinglePlayer
@onready var tab_multiplayer: VBoxContainer = $HBoxContainer/SubMenus/Multiplayer
#------------------------------------------------------------------------------#
#Signaled Functions
#Single Player
func _on_button_single_player_button_up() -> void:
	sub_menus.set_deferred("visible", true)
	tab_singleplayer.set_deferred("visible", true)
	NETWORK.single_player = true
#Multiplayer
func _on_button_multiplayer_button_up() -> void:
	sub_menus.set_deferred("visible", true)
	tab_multiplayer.set_deferred("visible", true)
	NETWORK.single_player = false
#Quit
func _on_button_quit_button_up() -> void: get_tree().quit()
