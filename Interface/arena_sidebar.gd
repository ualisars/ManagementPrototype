extends Control
@onready var left_sidebar_container: VBoxContainer = $LeftSidebarContainer
@onready var right_sidebar_container: VBoxContainer = $RightSidebarContainer

var CharacterFightInfo: PackedScene = preload("res://Interface/character_fight_info.tscn")

func add_characters(characteristics: Array, is_player: bool) -> void:
	for characteristic in characteristics:
		var character_fight_info = CharacterFightInfo.instantiate()
		
		if is_player:
			left_sidebar_container.add_child(character_fight_info)
		else:
			right_sidebar_container.add_child(character_fight_info)
		
		character_fight_info.set_character_name(characteristic.character_name)
		character_fight_info.set_max_health(characteristic.health)
	

func add_player_characters(characteristics: Array):
	add_characters(characteristics, true)
	
func add_enemy_characters(characteristics: Array):
	add_characters(characteristics, false)
