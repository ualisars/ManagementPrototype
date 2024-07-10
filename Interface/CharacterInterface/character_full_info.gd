extends Control

@onready var attack_value: Label = $CharacterInfoContainer/CharacteristicsContainer/AttackValue
@onready var defense_value: Label = $CharacterInfoContainer/CharacteristicsContainer/DefenseValue
@onready var health_value: Label = $CharacterInfoContainer/CharacteristicsContainer/HealthValue
@onready var concentration_value: Label = $CharacterInfoContainer/CharacteristicsContainer/ConcentrationValue
@onready var character_name: Label = $CharacterInfoContainer/GeneralInfoContainer/CharacterName

@onready var learnt_spell_container: GridContainer = $CharacterInfoContainer/LearntSpellContainer

@onready var level_progress_bar = $CharacterInfoContainer/LevelProgressBar
@onready var level_progress_bar_value = $CharacterInfoContainer/LevelProgressBar/LevelProgressBarValue
@onready var level_value = $CharacterInfoContainer/CharacteristicsContainer/LevelValue

@onready var level_up_button = $CharacterInfoContainer/LevelUpButton
@onready var available_spell_label = $VBoxContainer/AvailableSpellLabel

var current_character: Characterictic

var LearntSpellIconClass: PackedScene = preload("res://Interface/Spells/learnt_spell_icon.tscn")

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	Messenger.SPELL_LEARNT.connect(on_spell_learnt)
	
func on_character_info_chosen(characteristics: Characterictic) -> void:
	current_character = characteristics
	
	attack_value.text = str(current_character.attack)
	defense_value.text = str(current_character.defense)
	health_value.text = str(current_character.health)
	concentration_value.text = str(current_character.concentration)
	
	character_name.text = current_character.character_name
	
	init_learnt_spell_container()
	
	display_level(current_character)
	
	init_available_spell(current_character)
	
	init_level_up_button(current_character)
	
func on_spell_learnt(spell: Node) -> void:
	init_learnt_spell_container()
	
	init_available_spell(current_character)
	
func display_level(characteristics: Characterictic) -> void:
	var level: int = characteristics.level
	var next_level: int = level + 1
	
	var experience_to_next_level: int = LevelManager.get_level_points(next_level)
	var experience: int = characteristics.experience
	
	level_value.text = str(level)
	
	level_progress_bar.max_value = experience_to_next_level
	level_progress_bar.value = characteristics.experience
	
	level_progress_bar_value.text = str(experience) + "/" + str(experience_to_next_level)
	
	
func init_available_spell(characteristic: Characterictic) -> void:
	var text = "You have " + str(characteristic.available_spell_number) + " "
	text += "available spell"
	if characteristic.available_spell_number > 1:
		text += "s"
		
	available_spell_label.text = text
	
func init_level_up_button(characteristic: Characterictic) -> void:
	if characteristic.available_level_ups > 0:
		level_up_button.visible = true
	else:
		level_up_button.visible = false

	
func init_learnt_spell_container() -> void:
	for learnt_spell in learnt_spell_container.get_children():
		learnt_spell_container.remove_child(learnt_spell)
		learnt_spell.queue_free()
		
	for learnt_spell in current_character.learnt_spells:
			var spell_icon = LearntSpellIconClass.instantiate()
			spell_icon.texture = learnt_spell.spell_texture
			
			learnt_spell_container.add_child(spell_icon)
