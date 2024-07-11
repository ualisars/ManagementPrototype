extends VBoxContainer

class_name TaskContainer

@export var task_number: int

var task: Task

@onready var title_label: Label = $Title
@onready var task_provider_label: Label = $TaskProvider
@onready var task_texture: TextureRect = $TaskTexture

@onready var mage_number_value_label: Label = $HBoxContainer/MageNumberValue
@onready var bounty_value = $BountyMarginContainer/BountyContainer/BountyValue


func _ready() -> void:
	Messenger.INIT_TASK_CONTAINER.connect(on_init_task_container)

func _on_accept_button_pressed() -> void:
	Messenger.TASK_OPENED.emit(task)
	
func on_init_task_container(number: int, passed_task: Task):
	if task_number == number:
		task = passed_task
		
		init_container()

func init_container():
	title_label.text = task.task_title
	task_provider_label.text = task.task_provider
	mage_number_value_label.text = str(task.mage_number)
	bounty_value.text = str(task.bounty)
	
	var image = load(task.image_path)
	task_texture.texture = image
