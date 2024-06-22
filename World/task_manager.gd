extends Node

@export_file("*.jpg") var brigands_image
@export_file("*.jpg") var werewolves_image
@export_file("*.jpg") var vampires_image

var id: int = 1

var rng = RandomNumberGenerator.new()

var tasks: Array = []

var character_added_to_tasks: Dictionary

func _ready() -> void:
	Messenger.CHARACTER_ADDED_TO_TASK.connect(on_character_added_to_task)
	
	generate_tasks()
	
func on_character_added_to_task(characteristic: Characterictic, task: Task) -> void:
	add_character_to_task(characteristic, task)

func generate_tasks() -> void:
	for index in range(3):
		var task_number: int = index + 1
		var task = generate_task(task_number)
		tasks.append(task)

func generate_task(task_number: int) -> Task:
	var action: Task.ActionType = Task.ActionType.values().pick_random()
	var enemy: Task.EnemyType = Task.EnemyType.values().pick_random()
	var enemy_number: int = rng.randi_range(2, 6)
	var mage_number: int = rng.randi_range(2, 4)
	
	var provider: Task.TaskProvider = Task.TaskProvider.values().pick_random()
	
	var task: Task = Task.new()
	var image_path: String = add_image_path(enemy)
	
	task.init(
		action, 
		enemy, 
		enemy_number, 
		mage_number, 
		provider, 
		image_path, 
		id, 
		task_number
	)
	
	id += 1
	
	return task
	
func add_character_to_task(character: Characterictic, task: Task):
	var character_id: int = character.id
	
	if not character_added_to_tasks.get(character_id):
		var character_to_task = {
			"character": character,
			"task": task
		}
		character_added_to_tasks[character_id] = character_to_task
	
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
	
