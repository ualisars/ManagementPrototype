extends Control

@export_file("*.tscn") var parent_scene_file

@export var MAX_TASK_NUMBER: int = 3

@onready var task_characters_container: TextureRect = $TaskCharactersContainer


func _ready() -> void:
	Messenger.NEW_SCENE_OPENED.emit(parent_scene_file)
	
	Messenger.TASK_OPENED.connect(on_task_opened)
	
	Messenger.TASK_CLOSED.connect(on_task_closed)

	for index in MAX_TASK_NUMBER:
		var task: Task = TaskManager.tasks[index]
		var task_number: int = index + 1
		Messenger.INIT_TASK_CONTAINER.emit(task_number, task)
		
func on_task_opened(_task: Task):
	task_characters_container.visible = true
	

func on_task_closed():
	task_characters_container.visible = false
