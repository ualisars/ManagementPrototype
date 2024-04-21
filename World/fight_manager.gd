extends Node

var player_characters: Array
var enemy_characters: Array
var characters: Array

func set_fight(_player_characters: Array, _enemy_characters: Array) -> void:
	player_characters = _player_characters
	enemy_characters = _enemy_characters
	characters = player_characters + enemy_characters
	

func complete_turn():
	characters.sort_custom(cast_speed_array_sort)

func cast_speed_array_sort(character1, character2):
	if character1.cast_speed < character2.cast_speed:
		return true
	return false
	

func turn() -> void:
	for character in characters:
		pass
	
func attack(attack_character: Node, defend_character: Node) -> void:
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
