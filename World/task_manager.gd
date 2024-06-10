extends Node

var rng = RandomNumberGenerator.new()

var tasks: Array = []

func _ready() -> void:
	generate_tasks()

func generate_tasks():
	for index in range(3):
		var task = generate_task()
		tasks.append(task)

func generate_task():
	var action = Task.ActionType.values().pick_random()
	var enemy = Task.EnemyType.values().pick_random()
	var enemy_number = rng.randi_range(2, 6)
	
	var provider = Task.TaskProvider.values().pick_random()
	
	var task = Task.new()
	task.init(action, enemy, enemy_number, provider)
	
	return task
