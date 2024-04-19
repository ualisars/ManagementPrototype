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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for characteristic in Player.party:
		var index = rng.randi_range(0, player_locations.size() - 1)
		
		var location = player_locations[index]
		
		var character: Node3D = CharacterScene.instantiate()
		character.init(characteristic, true)
		
		character.global_position = location
		
		player_locations.remove_at(index)
		
		add_child(character)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
