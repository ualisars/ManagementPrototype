extends Control

@onready var attack_value: Label = $PlayerCharacteristicsContainer/AttackValue
@onready var defense_value: Label = $PlayerCharacteristicsContainer/DefenseValue
@onready var health_value: Label = $PlayerCharacteristicsContainer/HealthValue
@onready var concentration_value: Label = $PlayerCharacteristicsContainer/ConcentrationValue

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	
func on_character_info_chosen(characteristics: Node) -> void:
	attack_value.text = str(characteristics.attack)
	defense_value.text = str(characteristics.defense)
	health_value.text = str(characteristics.health)
	concentration_value.text = str(characteristics.concentration)
