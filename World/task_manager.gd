extends Node

@export_file("*.jpg") var brigands_image
@export_file("*.jpg") var werewolves_image
@export_file("*.jpg") var vampires_image

var id: int = 1

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
	var image_path: String = add_image_path(enemy)
	task.init(action, enemy, enemy_number, mage_number, provider, image_path, id)
	
	id += 1
	
	return task
	
func add_image_path(enemy_type: Task.EnemyType) -> String:
	match enemy_type:
		Task.EnemyType.BRIGAND:
			return brigands_image
		Task.EnemyType.VAMPIRE:
			return vampires_image
		Task.EnemyType.WEREWOLF:
			return werewolves_image
		_:
			print_debug("incorrect enemy type")
			return ""
	
