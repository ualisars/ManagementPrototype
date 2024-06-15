extends TextureRect

@export var characteristic_id: int

@onready var character_name: Label = $Name

@onready var attack_value: Label = $CharacteristicsLayout/AttackValue
@onready var defense_value: Label = $CharacteristicsLayout/DefenseValue
@onready var health_value: Label = $CharacteristicsLayout/HealthValue
@onready var concentration_value: Label = $CharacteristicsLayout/ConcentrationValue

var charactetistic: Characterictic


func _ready() -> void:
	Messenger.INIT_CHARACTER_INFO.connect(on_init_character_info)
	

func on_init_character_info(id: int, characteristic: Characterictic):
	if id == characteristic_id:
		character_name.text = str(characteristic.character_name)
		attack_value.text = str(characteristic.attack)
		defense_value.text = str(characteristic.defense)
		health_value.text = str(characteristic.health)
		concentration_value.text = str(characteristic.concentration)
		
		visible = true


func _on_add_pressed() -> void:
	print("add character to task")
