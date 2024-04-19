extends Node3D

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
	place_characters_on_arena(Player.party, player_locations, true)
	place_characters_on_arena(ArenaManager.generate_enemies(), enemy_locations, false)

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
		
		character.global_position = location
		
		locations.remove_at(index)
		
		add_child(character)
