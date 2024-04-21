extends Node

var player_characters: Array
var enemy_characters: Array
var characters: Array

var updated_player_characters: Array
var updated_enemy_characters: Array

var rng = RandomNumberGenerator.new()

var fight_ended: bool = false

func set_fight(_player_characters: Array, _enemy_characters: Array) -> void:
	player_characters = _player_characters.duplicate()
	enemy_characters = _enemy_characters.duplicate()
	characters = player_characters + enemy_characters

func cast_speed_array_sort(character1, character2):
	if character1.cast_speed < character2.cast_speed:
		return true
	return false

func turn() -> void:
	for character in characters:
		var enemy = choose_enemy(character)
		attack(character, enemy)
	
func attack(attack_character: Node, defend_character: Node) -> void:
	if fight_ended:
		return
	if attack_character.health > 0:
		var damage = attack_character.attack - defend_character.defense
		defend_character.health -= damage
		Messenger.UNIT_ATTACKED.emit(attack_character, defend_character)
		check_character_health(defend_character)

func check_win_loss_condition() -> void:
	if updated_player_characters.size() == 0:
		Messenger.FIGHT_ENDED.emit(false)
		fight_ended = true
	if updated_enemy_characters.size() == 0:
		Messenger.FIGHT_ENDED.emit(true)
		fight_ended = true
	
func check_character_health(character: Node) -> void:
	if character.health <= 0 and character.is_belongs_to_player:
		remove_character_by_id(character.id, updated_player_characters)
		check_win_loss_condition()
	if character.health <= 0 and not character.is_belongs_to_player:
		remove_character_by_id(character.id, updated_enemy_characters)
		check_win_loss_condition()

func clear_damaged_characters():
	var damaged_list: Array = [] 
	for character in characters:
		if character.health <= 0:
			damaged_list.append(character)
			
	for damaged_character in damaged_list:
		if damaged_character.is_belongs_to_player:
			remove_character_by_id(damaged_character.id, player_characters)
		else:
			remove_character_by_id(damaged_character.id, enemy_characters)
		remove_character_by_id(damaged_character.id, characters)

func remove_character_by_id(character_id: int, character_list: Array) -> void:
	for character in character_list:
		if character_id == character.id:
			character_list.erase(character)
	
func choose_enemy(character: Node) -> Node:
	if fight_ended:
		return
	if character.is_belongs_to_player:
		var enemy_index = rng.randi_range(0, updated_enemy_characters.size() - 1)
		return updated_enemy_characters[enemy_index]
	else:
		var player_index = rng.randi_range(0, updated_player_characters.size() - 1)
		return updated_player_characters[player_index]

func _on_timer_timeout() -> void:
	characters.sort_custom(cast_speed_array_sort)
	
	updated_player_characters = player_characters.duplicate()
	updated_enemy_characters = enemy_characters.duplicate()
	
	turn()
	
	clear_damaged_characters()
