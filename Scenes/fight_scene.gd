extends Node3D

@onready var fight_end_window: Control = $FightEndWindow
@onready var arena_sidebar: Control = $ArenaSidebar
@onready var arena_console: Control = $ArenaConsole

@export_file("*.tscn") var fight_over_scene

var Mage: PackedScene = preload("res://Models3D/apprentice_mage.tscn")

var current_task: Task

var player_characters: Array = []
var enemy_characters: Array = []

var player_characters_positions = [
	Vector3(-20.0, 0.0, -6.0),
	Vector3(-20.0, 0.0, -3.0),
	Vector3(-20.0, 0.0, 0.0),
	Vector3(-20.0, 0.0, 3.0),
	Vector3(-20.0, 0.0, 6.0),
	Vector3(-20.0, 0.0, 9.0),
]

var enemy_characters_positions = [
	Vector3(20.0, 0.0, -6.0),
	Vector3(20.0, 0.0, -3.0),
	Vector3(20.0, 0.0, 0.0),
	Vector3(20.0, 0.0, 3.0),
	Vector3(20.0, 0.0, 6.0),
	Vector3(20.0, 0.0, 9.0),
]


func _ready() -> void:
	fight_end_window.visible = false
	
	Messenger.FIGHT_ENDED.connect(on_fight_ended)
	
	var task_info: Dictionary = TaskManager.current_task_info
	var player_characteristics_list = task_info["characters"]
	
	place_characters(player_characteristics_list, true)
	
	var task: Task = task_info["task"]
	current_task = task
	
	var enemy_characteristics_list = task.characters
	
	place_characters(enemy_characteristics_list, false)
	
	arena_sidebar.add_player_characters(player_characters)
	arena_sidebar.add_enemy_characters(enemy_characters)
	
	FightManager.set_fight(player_characters, enemy_characters)
	FightManager.start_fight()
	

func move_to_fight_over_scene() -> void:
	var tween = create_tween()
	tween.tween_interval(3)
	tween.tween_callback(get_tree().change_scene_to_file.bind(fight_over_scene))


func on_fight_ended(is_player_win: bool) -> void:
		fight_end_window.add_after_fight_message(is_player_win)
		fight_end_window.visible = true
		
		move_to_fight_over_scene()
		
		if is_player_win:
			Player.add_gold(current_task.bounty)

func place_characters(characteristics_list: Array, is_player: bool) -> void:
	var locations: Array
	
	if is_player:
		locations = player_characters_positions
	else:
		locations = enemy_characters_positions
		
	for index in range(characteristics_list.size()):
		var location: Vector3 = locations[index]
		
		var characteristics: Node = characteristics_list[index]
		
		var character: Character3D = Mage.instantiate()
		character.init(characteristics, is_player)
		
		add_child(character)
		
		character.face_to_enemy()
		
		character.global_position = location
		
		if is_player:
			player_characters.append(character)
		else:
			enemy_characters.append(character)
