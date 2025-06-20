extends Sprite2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Integers
@export var height_counter: int = 1
#Arrays
@export var bases_average: Array[Resource] = []
@export var bases_chub: Array[Resource] = []
#OnReady Variables
#Local Nodes
@onready var sprites_character: Node2D = $"../.."
@onready var sprites_dictionary: Node2D = $"../../Sprites_Dictionary"
@onready var selection_character: HBoxContainer = $"../../../../.."
@onready var splash_screen: Control = $"../../../../../../../../../.."
@onready var ui_customization: HBoxContainer = splash_screen.get_parent().get_node("UI_Customization")
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void: ui_customization.connect("uic_height_change", uic_height_change)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Change Height
func uic_height_change(scroll):
	match(scroll):
		"Previous": height_counter -= 1
		"Next": height_counter += 1
	if height_counter == bases_average.size(): height_counter = 0
	elif height_counter < 0: height_counter = bases_average.size() -1
	sprites_dictionary.sprite_info["height"] = height_counter
	sprites_character.check_sprites(scroll)
#------------------------------------------------------------------------------#
#Custom Functions
#Check Base Texture
func check_base():
	var height
	if selection_character.is_new:
		if !sprites_dictionary.sprite_info["chub"]: texture = bases_average[height_counter]
		elif sprites_dictionary.sprite_info["chub"]: texture = bases_chub[height_counter]
		height = height_counter
	else:
		var counter = selection_character.character_counter
		var profiles = selection_character.save_container.button_save.profiles 
		height = int(profiles[counter].get("height"))
		if !profiles[counter].get("chub"):
			texture = bases_average[height]
		elif profiles[counter].get("chub"):
			texture = bases_chub[height]
	sprites_dictionary.sprite_paths.set("sprite_torso", texture.resource_path)
	if sprites_character.server_started:
		var id = multiplayer.get_unique_id()
		var path = texture.resource_path
		rpc("update_network_base", id, path, height)
#Update Network Dictionary
@rpc("any_peer", "call_local", "reliable")
func update_network_base(id, path, height):
	sprites_dictionary.NETWORK.players[id].set("sprite_torso", path)
	sprites_dictionary.NETWORK.players[id].set("height", height)
