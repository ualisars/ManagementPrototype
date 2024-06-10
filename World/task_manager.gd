extends Node

var rng = RandomNumberGenerator.new()

var tasks: Array = []

func _ready() -> void:
	generate_tasks()

func generate_tasks() -> void:
	for index in range(3):
		var task = generate_task()
		tasks.append(task)

func generate_task() -> Task:
	var action: Task.ActionType = Task.ActionType.values().pick_random()
	var enemy: Task.EnemyType = Task.EnemyType.values().pick_random()
	var enemy_number: int = rng.randi_range(2, 6)
	var mage_number: int = rng.randi_range(2, 4)
	
	var provider: Task.TaskProvider = Task.TaskProvider.values().pick_random()
	
	var task: Task = Task.new()
	task.init(action, enemy, enemy_number, mage_number, provider)
	
	return task
