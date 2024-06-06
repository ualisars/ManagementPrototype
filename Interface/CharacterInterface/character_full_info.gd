extends Control

@onready var attack_value: Label = $CharacterInfoContainer/CharacteristicsContainer/AttackValue
@onready var defense_value: Label = $CharacterInfoContainer/CharacteristicsContainer/DefenseValue
@onready var health_value: Label = $CharacterInfoContainer/CharacteristicsContainer/HealthValue
@onready var concentration_value: Label = $CharacterInfoContainer/CharacteristicsContainer/ConcentrationValue
@onready var character_name: Label = $CharacterInfoContainer/GeneralInfoContainer/CharacterName

@onready var learnt_spell_container: GridContainer = $CharacterInfoContainer/LearntSpellContainer

var LearntSpellIconClass: PackedScene = preload("res://Interface/CharacterInterface/learnt_spell_icon.tscn")

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	Messenger.SPELL_LEARNT.connect(on_spell_learnt)
	
func on_character_info_chosen(characteristics: Node) -> void:
	attack_value.text = str(characteristics.attack)
	defense_value.text = str(characteristics.defense)
	health_value.text = str(characteristics.health)
	concentration_value.text = str(characteristics.concentration)
	
	character_name.text = characteristics.character_name
	
	init_learnt_spell_container()
	
func on_spell_learnt(spell: Node):
	var spell_icon = LearntSpellIconClass.instantiate()
	spell_icon.texture = spell.spell_texture
		
	learnt_spell_container.add_child(spell_icon)
	
func init_learnt_spell_container():
	for learnt_spell in learnt_spell_container.get_children():
		learnt_spell_container.remove_child(learnt_spell)
		learnt_spell.queue_free()
		
	for learnt_spell in GameManager.current_character_chosen_in_camp.learnt_spells:
			var spell_icon = LearntSpellIconClass.instantiate()
			spell_icon.texture = learnt_spell.spell_texture
			
			learnt_spell_container.add_child(spell_icon)
