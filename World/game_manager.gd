extends Node

var current_character_chosen_in_camp: Node

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)


func on_character_info_chosen(characteristics: Node) -> void:
	current_character_chosen_in_camp = characteristics
