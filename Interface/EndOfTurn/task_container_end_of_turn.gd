extends VBoxContainer

@export var task_number: int

var task: Task
var character_infos: Array

var offset_number: int = 100
var start_number: int

@onready var title_label: Label = $Title
@onready var task_provider_label: Label = $TaskProvider
@onready var mage_number_value_label: Label = $HBoxContainer/MageNumberValue
@onready var mage_number_value: Label = $HBoxContainer/MageNumberValue

@onready var character_info_small_1: TextureRect = $ChosenCharacters/CharacterInfoSmall1
@onready var character_info_small_2: TextureRect = $ChosenCharacters/CharacterInfoSmall2
@onready var character_info_small_3: TextureRect = $ChosenCharacters/CharacterInfoSmall3
@onready var character_info_small_4: TextureRect = $ChosenCharacters/CharacterInfoSmall4
@onready var character_info_small_5: TextureRect = $ChosenCharacters/CharacterInfoSmall5
@onready var character_info_small_6: TextureRect = $ChosenCharacters/CharacterInfoSmall6


func _ready() -> void:
	Messenger.INIT_TASK_CONTAINER.connect(on_init_task_container)
	
	start_number = offset_number * task_number
	
	character_infos = [
		character_info_small_1,
		character_info_small_2,
		character_info_small_3,
		character_info_small_4,
		character_info_small_5,
		character_info_small_6,
	]

func on_init_task_container(number: int, passed_task: Task):
	if task_number == number:
		task = passed_task
		
		init_character_info()
		
		init_container()
		
		init_chosen_characters()
		
func init_container():
	title_label.text = task.task_title
	task_provider_label.text = task.task_provider
	mage_number_value_label.text = str(task.mage_number)
	
func init_character_info():
	for index in range(character_infos.size()):
		var character_info = character_infos[index]
		character_info.visible = false
		character_info.characteristic_id = start_number + index 
		
	
func init_chosen_characters():
	var current_task: Task
	var task_characters: Array = []
	
	for character_id in TaskManager.character_added_to_tasks:
		var task_data = TaskManager.character_added_to_tasks[character_id]
		
		var task: Task = task_data["task"]
		var characteristic: Characterictic = task_data["character"]
		
		if task.task_number == task_number:
			current_task = task
			task_characters.append(characteristic)
	
	if current_task and current_task.mage_number == task_characters.size():
		var character_info_id = start_number
		for characteristic in task_characters:
			Messenger.INIT_CHARACTER_INFO.emit(
				character_info_id, 
				characteristic, 
				task,
				false
			)
			character_info_id += 1
			
		Messenger.TASK_FILLED.emit(current_task, task_characters)
