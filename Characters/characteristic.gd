extends Node

class_name Characterictic

var health: int = 10
var attack: int = 2
var defense: int = 3
var cost: int = 5
var character_name = ""
var rng = RandomNumberGenerator.new()
var cast_speed: int
var id: int
var is_belongs_to_player: int
var concentration: int
var learnt_spells: Array = []

func _init() -> void:
	health = rng.randi_range(10, 30)
	attack = rng.randi_range(2, 5)
	defense = rng.randi_range(1, 3)
	cast_speed = rng.randi_range(2, 5)
	concentration = rng.randi_range(2, 6)
	cost = health + attack + defense + concentration
	
func add_id(new_id: int) -> void:
	id = new_id

func add_character_name(_character_name: String) -> void:
	character_name = _character_name

func add_belonging_to_player(is_player: bool) -> void:
	is_belongs_to_player = is_player
	
func learn_spell(spell: Node) -> void:
	learnt_spells.append(spell)
