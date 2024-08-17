extends Node3D

class_name Character3D

var characteristics: Characterictic

var attack: int
var defense: int :
	set(new_defense):
		defense = new_defense
		if defense <= 0:
			defense = 0
var health: int
var character_name: String
var is_player_controlled: bool
var cast_speed: int
var id: int
var is_belongs_to_player: bool
var cast_time: float
var concentration: int:
	set(new_concentration):
		concentration = new_concentration
		if concentration <= 0:
			concentration = 0

var is_wounded: bool = false

var damage_dealt: int = 0
var enemies_defeated: int = 0

@export var concentration_restoration: int

@export var timer_concentration: Timer
@export var timer_spell_cast: Timer
@export var character_rig: Node3D

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

var disabled: bool = false

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
	
	Messenger.SPELL_EFFECTS_APPLIED.connect(on_spell_effects_applied)
	
	Messenger.DEFENSE_DECREASE_STARTED.connect(on_defense_decrease_started)
	
	timer_concentration.timeout.connect(_on_timer_concentration_timeout)
	
	timer_spell_cast.timeout.connect(_on_timer_spell_cast_timeout)
	
func on_fight_started():
	timer_spell_cast.wait_time = cast_time
	timer_spell_cast.start()
	
	timer_concentration.start()
	
func cast_spell(enemy: Node3D):
	var spell: CharacterSpell = characteristics.choose_spell()
	var spell_particle = spell.spell_particle.instantiate()
	
	spell_particle.cast_time = calculate_cast_time(cast_speed)
	spell_particle.spell = spell
	spell_particle.damage = attack
	
	spell_particle.owner_character = self
	
	add_child(spell_particle)
	
	spell_particle.enemy_id = enemy.id
	spell_particle.target_character = enemy
	
	spell_particle.global_position = global_position + spell.spell_position3d
	
	spell_particle.direction = global_position.direction_to(enemy.global_position)

func on_spell_effects_applied(
	owner_character: Character3D, 
	target_character: Character3D, 
	spell3d: Spell3D
) -> void:
	if target_character.id != id:
		return
	
	for effect in spell3d.spell.effects:
		match effect:
			SpellEffects.Effects.DAMAGE:
				damage_character(owner_character, target_character, spell3d)
			SpellEffects.Effects.DECREASE_CONCENTRATION:
				decrease_concentration(owner_character, target_character, spell3d)
			SpellEffects.Effects.ATTACK_ALLY:
				attack_ally(owner_character, target_character, spell3d)
			SpellEffects.Effects.DECREASE_MAGIC_DEFENSE:
				decrease_magic_defense(owner_character, target_character, spell3d)

func damage_character(
	attack_character: Character3D, 
	defend_character: Character3D,
	spell3d: Spell3D
) -> void:
	if defend_character.id != id:
		return
		
	var damage: int = spell3d.calculate_damage(SpellDamageType.DamageType.HEALTH)

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
	spell3d: Spell3D
) -> void:
	if target_character.id != id:
		return
	
	concentration -= spell3d.calculate_damage(SpellDamageType.DamageType.CONCENTRATION)
	
	Messenger.CONCENTRATION_DESCREASED.emit(self)
	
	add_spell_effect_particle(spell3d)
		
func attack_ally(
	owner_character: Character3D,
	target_character: Character3D,
	spell3d: Spell3D
):
	if target_character.id != id:
		return
	
	var character_target: Character3D = FightManager.choose_ally(characteristics)
	if character_target:
		Messenger.SPELL_CANCELED.emit(self)
		add_spell_effect_particle(spell3d)
		cast_spell(character_target)
		timer_spell_cast.stop()
		timer_spell_cast.start()
		

func decrease_magic_defense(
	owner_character: Character3D,
	target_character: Character3D,
	spell3d: Spell3D
):
	if target_character.id != id:
		return
	
	var defense_decrease: int = spell3d.calculate_damage(SpellDamageType.DamageType.DEFENSE)
	Messenger.DEFENSE_DECREASE_STARTED.emit(self, defense_decrease, spell3d.spell_effect_duration)
	add_spell_effect_particle(spell3d)
	

func disable_unit() -> void:
	disabled = true
	is_wounded = true
	
	timer_spell_cast.stop()
	timer_concentration.stop()

func add_spell_effect_particle(spell3d: Spell3D) -> void:
	if spell3d.spell.spell_effect_particle:
		var particle: Node3D = spell3d.spell.spell_effect_particle.instantiate()
		particle.spell3D = spell3d
		particle.total_duration = spell3d.spell_effect_duration
		
		add_child(particle)
		
		particle.global_position = global_position + spell3d.spell.spell_effect_position3d

func calculate_cast_time(cast_speed: int) -> float:
	var maximum_cast_time: float = 5.0
	var minimum_cast_time: float = 0.4
	var maximum_cast_speed: float = 25.0
	var minimum_cast_speed: float = 1

	var slope = (minimum_cast_time - maximum_cast_time) / (maximum_cast_speed - minimum_cast_speed)

	var y_intercept = maximum_cast_time + (slope * minimum_cast_speed)

	var cast_time = slope * cast_speed + y_intercept

	return cast_time
	

func _on_timer_spell_cast_timeout() -> void: 
	if FightManager.check_enemy_exist(characteristics):
		var enemy: Node = FightManager.choose_enemy(characteristics)
		cast_spell(enemy)


func _on_timer_concentration_timeout():
	concentration += concentration_restoration
	Messenger.CONCENTRATION_CHANGED.emit(self)
	

func on_defense_decrease_started(character3d: Character3D, amount: int, effect_duration: float):
	if character3d.id != id:
		return
	
	if defense <= 0:
		return
	
	var defense_decrease_timer: Timer = Timer.new()
	
	defense_decrease_timer.timeout.connect(_on_defense_decrease_timer_timeout.bind(amount))
	defense_decrease_timer.one_shot = true
	defense_decrease_timer.wait_time = effect_duration
	defense_decrease_timer.autostart = true
	
	defense -= amount
	
	add_child(defense_decrease_timer)


func _on_defense_decrease_timer_timeout(defense_decrease: int):
	defense += defense_decrease
	
func face_to_enemy():
	if is_belongs_to_player:
		character_rig.rotate_y(60)
	else:
		character_rig.rotate_y(270)
