extends Node3D

class_name Character3D

var characteristics: Characterictic

var attack: int
var defense: int
var health: int
var character_name: String
var is_player_controlled: bool
var cast_speed: int
var id: int
var is_belongs_to_player: bool
var cast_time: float
var concentration: int

var is_wounded: bool = false

var damage_dealt: int = 0
var enemies_defeated: int = 0

@onready var timer: Timer = $Timer

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

var disabled: bool = false

@onready var body: MeshInstance3D = $Body

func init(_characteristics: Node, player_controlled: bool) -> void:
	characteristics = _characteristics
	attack = characteristics.attack
	defense = characteristics.defense
	health = characteristics.health
	concentration = characteristics.concentration
	character_name = characteristics.character_name
	cast_speed = characteristics.cast_speed
	is_player_controlled = player_controlled
	id = characteristics.id
	is_belongs_to_player = characteristics.is_belongs_to_player
	cast_time = calculate_cast_time(cast_speed)

func _ready() -> void:
	Messenger.FIGHT_STARTED.connect(on_fight_started)
	
	Messenger.SPELL_EFFECT_APPLIED.connect(on_spell_effect_applied)
	
	var material: StandardMaterial3D = StandardMaterial3D.new()
	
	if is_player_controlled:
		material.albedo_color = player_color
	else:
		material.albedo_color = enemy_color
		
	body.material_override = material
	
func on_fight_started():
	timer.wait_time = cast_time
	timer.start()
	
func cast_spell(enemy: Node3D):
	var spell: CharacterSpell = characteristics.choose_spell()
	var spell_particle = spell.spell_particle.instantiate()
	
	spell_particle.cast_time = calculate_cast_time(cast_speed)
	spell_particle.spell = spell
	spell_particle.damage = attack
	
	add_child(spell_particle)
	
	spell_particle.owner_character = self
	spell_particle.enemy_id = enemy.id
	spell_particle.target_character = enemy
	spell_particle.global_position = global_position + spell.spell_position3d
	
	spell_particle.direction = global_position.direction_to(enemy.global_position)

func on_spell_effect_applied(
	owner_character: Character3D, 
	target_character: Character3D, 
	spell: CharacterSpell
) -> void:
	if target_character.id != id:
		return
	
	match spell.effect:
		SpellEffects.Effects.DAMAGE:
			on_character_attacked(owner_character, target_character)
		SpellEffects.Effects.DECREASE_CONCENTRATION:
			decrease_concentration(owner_character, target_character, spell)
		SpellEffects.Effects.ATTACK_ALLY:
			attack_ally(owner_character, target_character, spell)

func on_character_attacked(
	attack_character: Character3D, 
	defend_character: Character3D
) -> void:
	if defend_character.id != id:
		return
		
	var damage: int = attack_character.attack

	if health > 0:
		health -= damage
		Messenger.CHARACTER_PENETRATED.emit(defend_character)
		characteristics.add_dealt_damage(damage)
		
	if health <= 0 and not disabled:
		disable_unit()
		FightManager.clear_wounded_character(self)
		FightManager.check_win_loss_condition()
		
		characteristics.add_defeated_enemy()

func decrease_concentration(
	owner_character: Character3D,
	target_character: Character3D,
	spell: CharacterSpell
) -> void:
	if target_character.id != id:
		return
	
	concentration -= owner_character.attack
	Messenger.CONCENTRATION_DESCREASED.emit(self)
	
	add_spell_effect_particle(spell)
		
func attack_ally(
	owner_character: Character3D,
	target_character: Character3D,
	spell: CharacterSpell
):
	if target_character.id != id:
		return
	
	var character_target: Character3D = FightManager.choose_ally(characteristics)
	if character_target:
		Messenger.SPELL_CANCELED.emit(self)
		add_spell_effect_particle(spell)
		cast_spell(character_target)
		timer.stop()
		timer.start()

func disable_unit() -> void:
	disabled = true
	is_wounded = true
	
	timer.stop()
	body.rotate_z(90.0)

func add_spell_effect_particle(spell: CharacterSpell) -> void:
	var particle: Node3D = spell.spell_effect_particle.instantiate()
	
	add_child(particle)
	
	particle.global_position = global_position + spell.spell_effect_position3d

func calculate_cast_time(cast_speed: int) -> float:
	var maximum_cast_time: float = 5.0
	var minimum_cast_time: float = 0.4
	var maximum_cast_speed: float = 25.0
	var minimum_cast_speed: float = 1

	var slope = (minimum_cast_time - maximum_cast_time) / (maximum_cast_speed - minimum_cast_speed)

	var y_intercept = maximum_cast_time + (slope * minimum_cast_speed)

	var cast_time = slope * cast_speed + y_intercept

	return cast_time
	

func _on_timer_timeout() -> void: 
	if FightManager.check_enemy_exist(characteristics):
		var enemy: Node = FightManager.choose_enemy(characteristics)
		cast_spell(enemy)
