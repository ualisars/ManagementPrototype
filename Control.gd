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


var update_characteristics_object: UpdateCharacteristicsObject

var attack_update: int
var defense_update: int
var health_update: int
var cast_speed_update: int

var is_attack_increased: bool = false
var is_defense_increased: bool = false
var is_health_increased: bool = false
var is_cast_speed_increased: bool = false

var available_points: int

var current_character: Characterictic

var GREEN_COLOR: Color = Color("004f00")

func _ready() -> void:
	Messenger.LEVEL_UP_OPENED.connect(on_level_up_chosen)
	
	attack_value_label.add_theme_font_size_override("font_size", 24)
	defense_value_label.add_theme_font_size_override("font_size", 24)
	health_value_label.add_theme_font_size_override("font_size", 24)
	cast_speed_value_label.add_theme_font_size_override("font_size", 24)
	
	attack_update = 1
	defense_update = 1
	health_update = 2
	cast_speed_update = 1
	

func on_level_up_chosen(characteristic: Characterictic) -> void:
	update_characteristics_object = UpdateCharacteristicsObject.new(0, 0, 0, 0)
	
	current_character = characteristic
	
	available_points = characteristic.available_level_ups * 2
	
	attack_value_label.text = str(characteristic.attack)
	defense_value_label.text = str(characteristic.defense)
	health_value_label.text = str(characteristic.health)
	cast_speed_value_label.text = str(characteristic.cast_speed)
	
	init_increase_buttons()
	
	update_points_label()
	
	check_accept_button()


func _on_cancel_button_pressed():
	Messenger.LEVEL_UP_CLOSED.emit()
	

func init_increase_buttons() -> void:
	attack_increase_button.text = "+" + str(attack_update)
	defense_increase_button.text = "+" + str(defense_update)
	health_increase_button.text = "+" + str(health_update)
	cast_speed_increase_button.text = "+" + str(cast_speed_update)

func _on_accept_button_pressed():
	if available_points == 0:
		update_characteristics()
		
		Messenger.CHARACTER_LEVEL_UP.emit(
			current_character,
			update_characteristics_object
		)
		
func update_points_label() -> void:
	points_label.text = "you have " + str(available_points) + " points"


func update_characteristics() -> void:
	if is_attack_increased:
		update_characteristics_object.attack = attack_update
	if is_defense_increased:
		update_characteristics_object.defense = defense_update
	if is_health_increased:
		update_characteristics_object.health = health_update
	if is_cast_speed_increased:
		update_characteristics_object.cast_speed = cast_speed_update

func update_button(
	button: Button, 
	label: Label, 
	update_value: int, 
	is_increased: bool
) -> bool:
	var updated_value: int = int(label.text)
	var is_value_updated = false
	
	if not is_increased and available_points > 0:
		button.text = "-"
		available_points -= 1
		updated_value += update_value
		label.add_theme_color_override("font_color", GREEN_COLOR)
		is_value_updated = true
	elif is_increased:
		button.text = "+" + str(update_value)
		available_points += 1
		updated_value -= update_value
		label.remove_theme_color_override("font_color")
		is_value_updated = true

	if is_value_updated:
		label.text = str(updated_value)
		
		update_points_label()
		check_accept_button()
	
	return is_value_updated

func check_accept_button() -> void:
	if available_points > 0:
		accept_button.disabled = true
	else:
		accept_button.disabled = false


func _on_attack_increase_button_pressed():
	var is_value_updated: bool = update_button(
		attack_increase_button,
		attack_value_label,
		attack_update, 
		is_attack_increased
	)
	
	if is_value_updated:
		is_attack_increased = !is_attack_increased


func _on_defense_increase_button_pressed():
	var is_value_updated: bool = update_button(
		defense_increase_button,
		defense_value_label,
		defense_update,
		is_defense_increased
	)
	
	if is_value_updated:
		is_defense_increased = !is_defense_increased


func _on_health_increase_button_pressed():
	var is_value_updated: bool = update_button(
		health_increase_button,
		health_value_label,
		health_update,
		is_health_increased
	)
	
	if is_value_updated:
		is_health_increased = !is_health_increased


func _on_cast_speed_increase_button_pressed():
	var is_value_updated: bool = update_button(
		cast_speed_increase_button,
		cast_speed_value_label,
		cast_speed_update,
		is_cast_speed_increased
	)
	
	if is_value_updated:
		is_cast_speed_increased = !is_cast_speed_increased
