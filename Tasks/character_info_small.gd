extends TextureRect

@export var characteristic_id: int

@onready var character_name: Label = $Name

@onready var attack_value: Label = $CharacteristicsLayout/AttackValue
@onready var defense_value: Label = $CharacteristicsLayout/DefenseValue
@onready var health_value: Label = $CharacteristicsLayout/HealthValue
@onready var concentration_value: Label = $CharacteristicsLayout/ConcentrationValue

@onready var add_button: Button = $ButtonContainer/AddButton
@onready var remove_button: Button = $ButtonContainer/RemoveButton

var charactetistic: Characterictic
var task: Task


func _ready() -> void:
	Messenger.INIT_CHARACTER_INFO.connect(on_init_character_info)
	
	Messenger.CHARACTER_INFO_STATE_CHANGES.connect(on_character_info_state_changed)
	
func on_init_character_info(id: int, _characteristic: Characterictic, _task: Task):
	if id == characteristic_id:
		charactetistic = _characteristic
		task = _task
		
		character_name.text = str(_characteristic.character_name)
		attack_value.text = str(_characteristic.attack)
		defense_value.text = str(_characteristic.defense)
		health_value.text = str(_characteristic.health)
		concentration_value.text = str(_characteristic.concentration)
		
		visible = true


func _on_add_pressed() -> void:
	Messenger.CHARACTER_ADDED_TO_TASK.emit(charactetistic, task)
	
	add_button.disabled = true
	
func on_character_info_state_changed(character_info_id: int) -> void:
	if characteristic_id == character_info_id:
		add_button.visible = false
		remove_button.visible = true
