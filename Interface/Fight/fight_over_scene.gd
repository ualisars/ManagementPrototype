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

var player_characters: Array
var enemy_characters: Array
var current_task: Task
var character_infos: Array

var player_win: bool

func _ready():
	Messenger.FIGHT_RESULT_CREATED.connect(on_fight_result_created)
	
	character_infos = [
		character_info_small_1,
		character_info_small_2,
		character_info_small_3,
		character_info_small_4,
		character_info_small_5,
		character_info_small_6
	]
	
	init_character_infos()

func on_fight_result_created(
	task: Task,
	player_characters3d: Array,
	enemy_characters3d: Array,
	is_player_win: bool
) -> void:
	current_task = task
	player_characters = player_characters3d
	enemy_characters = enemy_characters3d
	
	show_task()

func move_to_main_menu() -> void:
	var tween = create_tween()
	tween.tween_interval(0.2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(main_menu_scene_file))


func _on_close_button_pressed() -> void:
	move_to_main_menu()
	
func init_character_infos() -> void:
	for character_info in character_infos:
		character_info.visible = false
		
func show_task():
	if player_win:
		result_message_label.text = "Victory"
	else:
		result_message_label.text = "Defeat"
	
	task_description.text = current_task.task_title
	
