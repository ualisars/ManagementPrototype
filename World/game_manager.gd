extends Node

var current_character_chosen_in_camp: Node
var last_scene_file_path: String

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	Messenger.NEW_SCENE_OPENED.connect(on_new_scene_opened)


func on_character_info_chosen(characteristics: Node) -> void:
	current_character_chosen_in_camp = characteristics
	
func on_new_scene_opened(scene_file_path: String) -> void:
	print("last scene is: ", scene_file_path)
	last_scene_file_path = scene_file_path
