extends Node3D

@onready var arena_sidebar: Control = $ArenaSidebar

var rng = RandomNumberGenerator.new()

var CharacterScene: PackedScene = preload("res://Characters/character.tscn")

var player_locations: Array = [
	Vector3(-22.0, 0, 0), 
	Vector3(-22.0, 0, -6),
	Vector3(-22.0, 0, 6),
	Vector3(-14.0, 0, 3),
	Vector3(-14.0, 0, -3),
	Vector3(-14.0, 0, -9)
]
var enemy_locations: Array = [
	Vector3(22.0, 0, 0),
	Vector3(22.0, 0, -6),
	Vector3(22.0, 0, 6),
	Vector3(14.0, 0, 3),
	Vector3(14.0, 0, -3),
	Vector3(14.0, 0, 6)
]

func _ready() -> void:
	var enemies = ArenaManager.generate_enemies()
	place_characters_on_arena(Player.party, player_locations, true)
	place_characters_on_arena(enemies, enemy_locations, false)
	
	arena_sidebar.add_player_characters(Player.party)
	arena_sidebar.add_enemy_characters(enemies)
	
	FightManager.set_fight(Player.party, enemies)
	FightManager.complete_turn()

func place_characters_on_arena(
	characteristics: Array,
	locations: Array,
	is_player: bool
	) -> void:
	for characteristic in characteristics:
		var index = rng.randi_range(0, locations.size() - 1)
		
		var location = locations[index]
		
		var character: Node3D = CharacterScene.instantiate()
		character.init(characteristic, is_player)
		
		locations.remove_at(index)
		
		add_child(character)
		
		character.global_position = location
