extends Node3D

class_name Spell3D

var owner_character: Character3D
var enemy_id: int
var speed: int = 6
var target_position: Vector3
var direction: Vector3
var damage: int
var cast_speed: float
var spell: CharacterSpell
var target_character: Character3D

var cast_time: float

@export var concentration_to_cast: int
@export var concentration_to_max_damage: int
@export var concentration_to_min_damage: int

@export var max_damage: int
@export var min_damage: int

@export var max_concentration_damage: int = 0
@export var min_concentration_damage: int = 0

@export var cast_usage_speed: float
@export var spell_effect_duration: float

var elapsed_time: float = 0.0
var transition_amount: float = 0.0
var total_duration: float

var material: ShaderMaterial
var process_material: ParticleProcessMaterial

var current_scale: float

func _ready():
	owner_character.animate_prepare_spell()
	
	Messenger.SPELL_CANCELED.connect(on_spell_canceled)
	
	set_physics_process(false)

func _process(delta):
	if owner_character.is_wounded:
		set_process(false)
		queue_free()
		
	match spell.spell_interaction_type:
		CharacterSpell.SpellInterationType.PROJECTILE:
			prepare_projectile(delta)
		CharacterSpell.SpellInterationType.IMMATERIAL:
			prepare_immaterial(delta)


func _physics_process(delta: float) -> void:
	if owner_character and owner_character.is_wounded:
		set_physics_process(false)
		queue_free()

	position += direction * speed * delta

func on_spell_canceled(character3d: Character3D):
	if owner_character.id == character3d.id:
		queue_free()

func apply_spell_effect(enemy_character: Character3D):
	Messenger.SPELL_EFFECT_APPLIED.emit(
		owner_character,
		enemy_character,
		Spell3D
	)

func calculate_damage(damage_type: SpellDamageType.DamageType) -> int:
	var _max_damage: int = max_damage
	var _min_damage: int = min_damage
	
	match damage_type:
		SpellDamageType.DamageType.HEALTH:
			_max_damage = max_damage
			_min_damage = min_damage
		SpellDamageType.DamageType.CONCENTRATION:
			_max_damage = max_concentration_damage
			_min_damage = min_concentration_damage
		SpellDamageType.DamageType.DEFENSE:
			_max_damage = max_damage
			_min_damage = min_damage

	if owner_character.concentration <= concentration_to_min_damage:
		return _min_damage
	elif owner_character.concentration >= concentration_to_max_damage:
		return _max_damage
	else:
		var slope: float = (_max_damage - _min_damage) / (concentration_to_max_damage - concentration_to_min_damage)
		var damage: float = _min_damage + slope * (owner_character.concentration - concentration_to_min_damage)
		return int(damage)
		
func prepare_projectile(delta):
	elapsed_time += delta

	transition_amount = lerp(0.0, 1.0, elapsed_time / total_duration)
	
	if transition_amount >= 1.0:
		set_process(false)
		set_physics_process(true)
		
		Messenger.RESET_CAST.emit(owner_character)

func prepare_immaterial(delta):
	elapsed_time += delta

	transition_amount = lerp(0.0, 1.0, elapsed_time / total_duration)

	transition_amount = clamp(transition_amount, 0.0, 1.0)
	
	process_material.scale_min = transition_amount

	if transition_amount >= 1.0:
		for effect in spell.effects:
			Messenger.SPELL_EFFECTS_APPLIED.emit(
				owner_character,
				target_character,
				self
			)
			
			owner_character.animate_cast_immaterial()
			Messenger.RESET_CAST.emit(owner_character)
			
		set_process(false)
		queue_free()

	material.set_shader_parameter("TransitionAmount", transition_amount)
