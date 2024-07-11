extends Node

class_name Characterictic

var health: int = 10
var attack: int = 2
var defense: int = 3
var cost: int = 5
var character_name = ""
var rng = RandomNumberGenerator.new()
var cast_speed: int
var id: int
var is_belongs_to_player: int
var concentration: int
var learnt_spells: Array = []
var available_spell_number: int = 0
var available_level_ups: int = 1

var level: int = 1
var experience: int = 0 :
	set(new_experience):
		var next_level: int = level + 1
		var next_level_exp: int = LevelManager.get_level_points(next_level)
		
		var exp_after: int = new_experience
		
		if new_experience >= next_level_exp:
			level += 1
			available_spell_number += 1
			available_level_ups += 1
			exp_after = new_experience - next_level_exp
			
		experience = exp_after
			
var damage_dealth: int = 0
var enemies_defeated: int = 0

func _init() -> void:
	health = rng.randi_range(10, 30)
	attack = rng.randi_range(2, 5)
	defense = rng.randi_range(1, 3)
	cast_speed = rng.randi_range(2, 5)
	concentration = rng.randi_range(2, 6)
	
	cost = health + attack + defense + concentration + cast_speed
	
func add_id(new_id: int) -> void:
	id = new_id

func add_character_name(_character_name: String) -> void:
	character_name = _character_name

func add_belonging_to_player(is_player: bool) -> void:
	is_belongs_to_player = is_player

func learn_spell(spell: Node) -> void:
	if available_spell_number > 0 and not is_spell_learnt(spell):
		learnt_spells.append(spell)
		available_spell_number -= 1

func add_dealt_damage(damage: int) -> void:
	damage_dealth += damage

func add_defeated_enemy() -> void:
	enemies_defeated += 1

func reset_fight_properties() -> void:
	damage_dealth = 0
	enemies_defeated = 0

func is_spell_learnt(spell: Node) -> bool:
	for learnt_spell in learnt_spells:
		if spell.spell_name == learnt_spell.spell_name:
			return true
	return false
