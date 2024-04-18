extends Node

var health: int = 10
var attack: int = 2
var defense: int = 3
var cost: int = 5
var character_name = ""
var rng = RandomNumberGenerator.new()
var id: int

var names: Array = ["Arw", "Teon", "Mid", "Jecw", "Unsa", "Lefs", "Yevil"]

func _init() -> void:
	health = rng.randi_range(8, 20)
	attack = rng.randi_range(4, 7)
	defense = rng.randi_range(1, 3)
	character_name = names.pick_random()
	cost = health + attack + defense
	
func add_id(new_id: int) -> void:
	id = new_id
