extends Control

var MAX_TASK_NUMBER: int = 3
var filled_tasks_number: int = 0
var filled_tasks: Array = []

@export_file("*.tscn") var fight_scene_file

@onready var end_of_turn_button: Button = $Background/EndOfTurnButton

func _ready() -> void:
	Messenger.TASK_FILLED.connect(on_task_filled)
	
	for index in MAX_TASK_NUMBER:
		var task: Task = TaskManager.tasks[index]
		var task_number: int = index + 1
		Messenger.INIT_TASK_CONTAINER.emit(task_number, task)
		
	if filled_tasks_number > 0:
		end_of_turn_button.disabled = false
		
func on_task_filled(task: Task, characterisctics: Array) -> void:
	var task_to_character = {
			"characters": characterisctics,
			"task": task
		}
	filled_tasks.append(task_to_character)
	filled_tasks_number += 1
	
	end_of_turn_button.disabled = false
	
func open_fight_scene():
	var tween = create_tween()
	tween.tween_interval(0.1)
	tween.tween_callback(get_tree().change_scene_to_file.bind(fight_scene_file))


func _on_end_of_turn_button_pressed() -> void:
	if filled_tasks_number > 0:
		var chosen_task = filled_tasks[0]
		TaskManager.set_current_task(chosen_task)
		
		open_fight_scene()
