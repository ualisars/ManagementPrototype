extends Node3D

@onready var arena_sidebar: Control = $ArenaSidebar

var rng = RandomNumberGenerator.new()

var CharacterScene: PackedScene = preload("res://Characters/character.tscn")
@onready var fight_end_window: Control = $FightEndWindow

var player_characters: Array = []
var enemy_characters: Array = []

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
	fight_end_window.visible = false
	
	Messenger.FIGHT_ENDED.connect(on_fight_ended)
	
	var enemies = ArenaManager.generate_enemies()
	place_characters_on_arena(Player.party, player_locations, true)
	place_characters_on_arena(enemies, enemy_locations, false)
	
	arena_sidebar.add_player_characters(player_characters)
	arena_sidebar.add_enemy_characters(enemy_characters)
	
	FightManager.set_fight(player_characters, enemy_characters)
	FightManager.start_fight()
	

func on_fight_ended(is_player_win: bool) -> void:
		fight_end_window.add_after_fight_message(is_player_win)
		fight_end_window.visible = true

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
		
		if is_player:
			player_characters.append(character)
		else:
			enemy_characters.append(character)
