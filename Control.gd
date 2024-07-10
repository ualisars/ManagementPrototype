extends Control

@onready var level_up_label = $BoxContainer/LevelUpLabel
@onready var points_label = $BoxContainer/PointsLabel

@onready var attack_value_label = $BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/AttackCharacteristicContainer/AttackValueLabel
@onready var defense_value_label = $BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/DefenseCharacteristicContainer/DefenseValueLabel
@onready var health_value_label = $BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/HealthCharacteristicContainer/HealthValueLabel
@onready var cast_speed_value_label = $BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/CastSpeedCharacteristicContainer/CastSpeedValueLabel

@onready var attack_increase_button = $BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/AttackCharacteristicContainer/AttackIncreaseButton
@onready var defense_increase_button = $"BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/DefenseCharacteristicContainer/DefenseIncrease Button"
@onready var health_increase_button = $"BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/HealthCharacteristicContainer/HealthIncrease Button"
@onready var cast_speed_increase_button = $"BoxContainer/CharacteristicsMarginContainer/CharacteristicsContainer/CastSpeedCharacteristicContainer/CastSpeedIncrease Button"

@onready var accept_button = $BoxContainer/ButtonsMarginContainer/ButtonsBoxContainer/AcceptButton
@onready var cancel_button = $BoxContainer/ButtonsMarginContainer/ButtonsBoxContainer/CancelButton


func _ready() -> void:
	Messenger.LEVEL_UP_OPENED.connect(on_level_up_chosen)
	

func on_level_up_chosen(characteristic: Characterictic) -> void:
	attack_value_label.text = str(characteristic.attack)
	defense_value_label.text = str(characteristic.defense)
	health_value_label.text = str(characteristic.health)
	cast_speed_value_label.text = str(characteristic.cast_speed)


func _on_cancel_button_pressed():
	Messenger.LEVEL_UP_CLOSED.emit()
