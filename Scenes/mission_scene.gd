extends Control

var MAX_TASK_NUMBER: int = 3

@onready var title1: Label = $TasksContainer/TaskContainer1/Title
@onready var title2: Label = $TasksContainer/TaskContainer2/Title
@onready var title3: Label = $TasksContainer/TaskContainer3/Title

@onready var task_provider1: Label = $TasksContainer/TaskContainer1/TaskProvider
@onready var task_provider2: Label = $TasksContainer/TaskContainer2/TaskProvider
@onready var task_provider3: Label = $TasksContainer/TaskContainer3/TaskProvider

@onready var mage_number_value1: Label = $TasksContainer/TaskContainer1/HBoxContainer/MageNumberValue
@onready var mage_number_value2: Label = $TasksContainer/TaskContainer2/HBoxContainer/MageNumberValue
@onready var mage_number_value3: Label = $TasksContainer/TaskContainer3/HBoxContainer/MageNumberValue


func _ready() -> void:
	var titles = [
		title1,
		title2,
		title3
	]
	
	var providers = [
		task_provider1,
		task_provider2,
		task_provider3
	]
	
	var mage_numbers = [
		mage_number_value1,
		mage_number_value2,
		mage_number_value3
	]
	
	for index in MAX_TASK_NUMBER:
		var task: Task = TaskManager.tasks[index]
		
		var title: Label = titles[index]
		title.text = task.task_title
		
		var provider: Label = providers[index]
		provider.text = task.task_provider
		
		var mage_number: Label = mage_numbers[index]
		mage_number.text = str(task.enemy_number)
