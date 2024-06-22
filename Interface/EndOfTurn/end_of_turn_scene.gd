extends Control

var MAX_TASK_NUMBER: int = 3

func _ready() -> void:
	for index in MAX_TASK_NUMBER:
		var task: Task = TaskManager.tasks[index]
		var task_number: int = index + 1
		Messenger.INIT_TASK_CONTAINER.emit(task_number, task)
