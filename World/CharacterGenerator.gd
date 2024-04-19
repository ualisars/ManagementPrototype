extends Node

var CharacterCharacteristics: PackedScene = preload("res://Characters/character_characteristics.tscn")

var id: int = 1

var academy_characters: Array = []

func create_character() -> Node:
	var characteristics = CharacterCharacteristics.instantiate()
	characteristics.add_id(id)
	id += 1
	
	return characteristics
	

func add_academy_characters() -> void:
	for i in range(5):
		var character = create_character()
		academy_characters.append(character)

func remove_acamedy_character(character: Node):
	var index = academy_characters.find(character)
	academy_characters.remove_at(index)

func _ready() -> void:
	add_academy_characters()
