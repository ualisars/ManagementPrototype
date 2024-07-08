extends Control


@export_file("*.tscn") var main_menu_scene_file

@onready var character_info_small_1 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall1
@onready var character_info_small_2 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall2
@onready var character_info_small_3 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall3
@onready var character_info_small_4 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall4
@onready var character_info_small_5 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall5
@onready var character_info_small_6 = $VBoxContainer/CharactersInfoContainer/CharactersContainer/CharacterInfoSmall6

@onready var result_message_label = $VBoxContainer/ResultMessageLabel
@onready var task_description = $VBoxContainer/TaskDescription

var player_characteristics: Array
var enemy_characteristics: Array
var task: Task
var character_infos: Array

var is_player_win: bool

var start_characteris_id: int = 401

func _ready():
	is_player_win = FightManager.is_player_win
	player_characteristics = FightManager.get_player_characteristics()
	enemy_characteristics = FightManager.get_enemy_characteristics()
	task = TaskManager.current_task_info["task"]
	
	character_infos = [
		character_info_small_1,
		character_info_small_2,
		character_info_small_3,
		character_info_small_4,
		character_info_small_5,
		character_info_small_6
	]
	
	init_character_infos()
	
	show_task()
	show_player_characters()

func move_to_main_menu() -> void:
	var tween = create_tween()
	tween.tween_interval(0.2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(main_menu_scene_file))


func _on_close_button_pressed() -> void:
	move_to_main_menu()
	
	TaskManager.reset_tasks()
	
func init_character_infos() -> void:
	for character_info in character_infos:
		character_info.visible = false
		
func show_task() -> void:
	if is_player_win:
		result_message_label.text = "Victory"
	else:
		result_message_label.text = "Defeat"
	
	task_description.text = task.task_title
	
func show_player_characters() -> void:
	init_character_infos()
	
	for index in range(0, player_characteristics.size()):
		var characteristic_id : int = start_characteris_id + index
		
		var characteristics: Characterictic = player_characteristics[index]
		
		Messenger.INIT_CHARACTER_INFO.emit(
			characteristic_id, 
			characteristics,
			task,
			true
		)
		
		characteristics.reset_fight_properties()
