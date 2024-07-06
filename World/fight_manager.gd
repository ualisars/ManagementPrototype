extends Node

var player_characters_3d: Array
var enemy_characters_3d: Array
var characters_3d: Array
var all_characters3d: Array

var player_characteristics: Array
var enemy_characteristics: Array

var rng = RandomNumberGenerator.new()

var fight_ended: bool = false
var is_player_win: bool

func set_fight(
	_player_characters_3d: Array,
	_enemy_characters_3d: Array
) -> void:
	fight_ended = false
	
	player_characters_3d = _player_characters_3d
	enemy_characters_3d = _enemy_characters_3d
	
	characters_3d = player_characters_3d + enemy_characters_3d
	all_characters3d = characters_3d.duplicate()

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
		is_player_win = false
		fight_ended = true
	if enemy_characters_3d.size() == 0:
		is_player_win = true
		fight_ended = true
		
	if fight_ended:
		init_characteristics()
		Messenger.FIGHT_ENDED.emit(is_player_win)
	

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
	
func get_player_characteristics() -> Array:
	return player_characteristics

func get_enemy_characteristics() -> Array:
	return enemy_characteristics

func init_characteristics() -> void:
	for character3d: Character3D in all_characters3d:
		var characteristics: Characterictic = character3d.characteristics
		var gained_experience: int = calculate_gained_experience(characteristics)
		characteristics.experience += gained_experience
		
		if character3d.is_belongs_to_player:
			player_characteristics.append(characteristics)
		else:
			enemy_characteristics.append(characteristics)

func calculate_gained_experience(characteristics: Characterictic) -> int:
	var experience: int = characteristics.damage_dealth * 10
	experience += characteristics.enemies_defeated * 100
	return experience
