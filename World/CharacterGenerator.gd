extends Node

var CharacteristicClass: PackedScene = preload("res://Characters/characteristic.tscn")

var rng = RandomNumberGenerator.new()

var names: Array

var id: int = 1

var academy_characters: Array = []

func _ready() -> void:
	add_academy_characters()
	
	Messenger.FIGHT_ENDED.connect(on_fight_ended)
	

func on_fight_ended(_is_player_win: bool) -> void:
	add_academy_characters()

func create_character(is_player) -> Characterictic:
	var characteristic = CharacteristicClass.instantiate()
	characteristic.add_id(id)
	characteristic.add_belonging_to_player(is_player)
	
	var character_name = pick_name()
	
	characteristic.add_character_name(character_name)
	id += 1
	
	return characteristic

func pick_name() -> String:
	if names.size() == 0:
		add_names()

	var index = rng.randi_range(0, names.size() - 1)
	
	var character_name = names[index]
	
	names.remove_at(index)
	
	return character_name

func add_academy_characters() -> void:
	academy_characters = []
	for i in range(5):
		var character = create_character(false)
		academy_characters.append(character)

func remove_acamedy_character(character: Node) -> void:
	var index = academy_characters.find(character)
	academy_characters.remove_at(index)
	

func add_names() -> void:
	names = [
		"Arw", 
		"Teon", 
		"Mid", 
		"Jecw", 
		"Unsa", 
		"Lefs", 
		"Yevil",
		"Vilkas",
		"Pols",
		"Gen",
		"Trendor",
		"Avinor",
		"Bob",
		"Uni",
		"Telver",
		"Agitus"
	]
