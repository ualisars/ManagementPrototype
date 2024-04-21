extends Node

var CharacteristicClass: PackedScene = preload("res://Characters/characteristic.tscn")

var id: int = 1

var academy_characters: Array = []

func create_character(is_player) -> Node:
	var characteristic = CharacteristicClass.instantiate()
	characteristic.add_id(id)
	characteristic.add_belonging_to_player(is_player)
	id += 1
	
	return characteristic
	

func add_academy_characters() -> void:
	for i in range(5):
		var character = create_character(false)
		academy_characters.append(character)

func remove_acamedy_character(character: Node):
	var index = academy_characters.find(character)
	academy_characters.remove_at(index)

func _ready() -> void:
	add_academy_characters()
