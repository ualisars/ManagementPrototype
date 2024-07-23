extends Control
@onready var left_sidebar_container: VBoxContainer = $LeftSidebarContainer
@onready var right_sidebar_container: VBoxContainer = $RightSidebarContainer

var CharacterFightInfo: PackedScene = preload("res://Interface/Arena/character_fight_info.tscn")

func add_characters(characters3d: Array, is_player: bool) -> void:
	for character3d in characters3d:
		var character_fight_info = CharacterFightInfo.instantiate()
		
		if is_player:
			left_sidebar_container.add_child(character_fight_info)
		else:
			right_sidebar_container.add_child(character_fight_info)
		
		character_fight_info.set_character_name(character3d.character_name)
		character_fight_info.set_max_health(character3d.health)
		character_fight_info.set_character_id(character3d.id)
		character_fight_info.set_max_concentration(character3d.concentration)

func add_player_characters(characters3d: Array):
	add_characters(characters3d, true)
	
func add_enemy_characters(characters3d: Array):
	add_characters(characters3d, false)
