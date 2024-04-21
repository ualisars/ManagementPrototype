extends Node

var player_characters: Array
var enemy_characters: Array
var characters: Array

var rng = RandomNumberGenerator.new()

func set_fight(_player_characters: Array, _enemy_characters: Array) -> void:
	player_characters = _player_characters
	enemy_characters = _enemy_characters
	characters = player_characters + enemy_characters
	

func complete_turn():
	characters.sort_custom(cast_speed_array_sort)
	
	turn()

func cast_speed_array_sort(character1, character2):
	if character1.cast_speed < character2.cast_speed:
		return true
	return false
	

func turn() -> void:
	for character in characters:
		var enemy = choose_enemy(character)
		attack(character, enemy)
	
func attack(attack_character: Node, defend_character: Node) -> void:
	var damage = attack_character.attack - defend_character.defense
	defend_character.health -= damage
	Messenger.UNIT_ATTACKED.emit(attack_character, defend_character)
	

func choose_enemy(character: Node) -> Node:
	if character.is_belongs_to_player:
		var index = rng.randi_range(0, enemy_characters.size() - 1)
		return enemy_characters[index]
	var index = rng.randi_range(0, player_characters.size() - 1)
	return player_characters[index]
