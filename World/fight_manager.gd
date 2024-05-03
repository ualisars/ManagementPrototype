extends Node

var player_characters_3d: Array
var enemy_characters_3d: Array
var characters_3d: Array

var rng = RandomNumberGenerator.new()

var fight_ended: bool = false

func set_fight(
	_player_characters_3d: Array,
	_enemy_characters_3d: Array
) -> void:
	player_characters_3d = _player_characters_3d
	enemy_characters_3d = _enemy_characters_3d
	
	characters_3d = player_characters_3d + enemy_characters_3d

func get_character_3d_by_id(id: int) -> Node3D:
	for character in characters_3d:
		if character.id == id:
			return character
	return 

func remove_character_by_id(character_id: int, character_list: Array) -> void:
	for character in character_list:
		if character_id == character.id:
			character_list.erase(character)

func start_fight():
	Messenger.FIGHT_STARTED.emit()
	

func check_win_loss_condition() -> void:
	if player_characters_3d.size() == 0:
		Messenger.FIGHT_ENDED.emit(false)
		fight_ended = true
	if enemy_characters_3d.size() == 0:
		Messenger.FIGHT_ENDED.emit(true)
		fight_ended = true
	

func clear_wounded_character(character3d: Node3D):
	remove_character_by_id(character3d.id, characters_3d)
	
	if character3d.is_belongs_to_player:
		remove_character_by_id(character3d.id, player_characters_3d)
	else:
		remove_character_by_id(character3d.id, enemy_characters_3d)

func choose_enemy(characteristics: Node) -> Node3D:
	if characteristics.is_belongs_to_player:
		var enemy_index = rng.randi_range(0, enemy_characters_3d.size() - 1)
		return enemy_characters_3d[enemy_index]
	else:
		var player_index = rng.randi_range(0, player_characters_3d.size() - 1)
		return player_characters_3d[player_index]
		
func check_enemy_exist(characteristics: Node) -> bool:
	if characteristics.is_belongs_to_player and enemy_characters_3d.size() == 0:
		return false
	elif not characteristics.is_belongs_to_player and player_characters_3d.size() == 0:
		return false
	return true
