extends VBoxContainer

class_name TaskContainer

@onready var title_label: Label = $Title
@onready var task_provider_label: Label = $TaskProvider
@onready var description_label: Label = $Description
@onready var task_texture_label: TextureRect = $TaskTexture
@onready var bounty_value_label: Label = $BountyMarginContainer/BountyContainer/BountyValue
@onready var mage_number_value_label: Label = $HBoxContainer/MageNumberValue


var title: String
var provider: String
var mage_number_value: String

func init(task: Task) -> void:
	title = task.task_title
	provider = str(task.task_provider)
	mage_number_value = str(task.enemy_number)
