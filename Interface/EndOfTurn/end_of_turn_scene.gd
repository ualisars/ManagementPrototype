extends Control

var MAX_TASK_NUMBER: int = 3
var filled_tasks_number: int = 0
var filled_tasks: Dictionary

@onready var end_of_turn_button: Button = $Background/EndOfTurnButton

func _ready() -> void:
	Messenger.TASK_FILLED.connect(on_task_filled)
	
	for index in MAX_TASK_NUMBER:
		var task: Task = TaskManager.tasks[index]
		var task_number: int = index + 1
		Messenger.INIT_TASK_CONTAINER.emit(task_number, task)
		
	if filled_tasks_number > 0:
		end_of_turn_button.disabled = false
		
func on_task_filled(task: Task, characterisctics: Array):
	var task_to_character = {
			"character": characterisctics,
			"task": task
		}
	filled_tasks[task.task_number] = task_to_character
	filled_tasks_number += 1
	end_of_turn_button.disabled = false
