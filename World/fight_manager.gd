extends Node

var player_characters: Array
var enemy_characters: Array
var characters: Array

var rng = RandomNumberGenerator.new()

func set_fight(_player_characters: Array, _enemy_characters: Array) -> void:
	player_characters = _player_characters
	enemy_characters = _enemy_characters
	characters = player_characters + enemy_characters
	

#'func complete_turn():
	#characters.sort_custom(cast_speed_array_sort)
	#
	#turn()
	#
	#clear_damaged_characters'()

func cast_speed_array_sort(character1, character2):
	if character1.cast_speed < character2.cast_speed:
		return true
	return false
	

func turn() -> void:
	for character in characters:
		var enemy = choose_enemy(character)
		attack(character, enemy)
	
func attack(attack_character: Node, defend_character: Node) -> void:
	if attack_character.health > 0:
		var damage = attack_character.attack - defend_character.defense
		defend_character.health -= damage
		Messenger.UNIT_ATTACKED.emit(attack_character, defend_character)
		

func check_win_loss_condition():
	if player_characters.size() == 0 or enemy_characters.size() == 0:
		return true
	return false

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
	for index in range(0, character_list.size() - 1):
		if character_id == character_list[index].id:
			character_list.remove_at(index)
	
func choose_enemy(character: Node) -> Node:
	if character.is_belongs_to_player:
		var enemy_index = rng.randi_range(0, enemy_characters.size() - 1)
		return enemy_characters[enemy_index]
	var player_index = rng.randi_range(0, player_characters.size() - 1)
	return player_characters[player_index]



func _on_timer_timeout() -> void:
	characters.sort_custom(cast_speed_array_sort)
	
	turn()
	
	clear_damaged_characters()
