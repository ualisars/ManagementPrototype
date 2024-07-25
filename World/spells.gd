extends Node

var fireball: CharacterSpell = CharacterSpell.new()
var domination: CharacterSpell = CharacterSpell.new()
var distraction: CharacterSpell = CharacterSpell.new()
var despair: CharacterSpell = CharacterSpell.new()
var apathy: CharacterSpell = CharacterSpell.new()
var insanity: CharacterSpell = CharacterSpell.new()
var necromancy: CharacterSpell = CharacterSpell.new()
var decay: CharacterSpell = CharacterSpell.new()
var roots: CharacterSpell = CharacterSpell.new()
var blindness: CharacterSpell = CharacterSpell.new()
var divine_hammer: CharacterSpell = CharacterSpell.new()
var selestial_support: CharacterSpell = CharacterSpell.new()

@export var fireball_particle: PackedScene
@export var distraction_particle: PackedScene
@export var distraction_effect_particle: PackedScene
@export var domination_cast_particle: PackedScene
@export var domination_effect_particle: PackedScene

var spells: Dictionary = {}

func _ready():
	init_spells()

func init_spells():
	if spells.size() > 0:
		return
	
	fireball.init(
		"Fireball",
		"Elemental",
		"Cast a fireball dealt magic damage",
		SpellEffects.Effects.DAMAGE,
		UiCommon.fireball_spell_texture
	)
	
	fireball.add_spell_particle(fireball_particle)
	fireball.add_spell_position_3d(Vector3(0, 1.2, 0))
	
	spells["fireball"] = fireball
	
	domination.init(
		"Domination",
		"Physic",
		"Force enemy to attack their ally",
		SpellEffects.Effects.ATTACK_ALLY,
		UiCommon.domination_spell_texture
	)
	
	domination.add_spell_particle(domination_cast_particle)
	domination.add_spell_effect_particle(domination_effect_particle)
	domination.add_spell_position_3d(Vector3(0, 4.0, 0))
	domination.add_spell_effect_position_3d(Vector3(0, 4.0, 0))
	
	spells["domination"] = domination
	
	distraction.init(
		"Distraction",
		"Physic",
		"Decrease enemy's concentration",
		SpellEffects.Effects.DECREASE_CONCENTRATION,
		UiCommon.distraction_spell_texture
	)
	
	distraction.add_spell_particle(distraction_particle)
	distraction.add_spell_effect_particle(distraction_effect_particle)
	distraction.add_spell_position_3d(Vector3(0, 1.2, 0))
	distraction.add_spell_effect_position_3d(Vector3(0, 2.4, 0))
	
	spells["distraction"] = distraction

	despair.init(
		"Despair",
		"Physic",
		"Force enemy to attack youself",
		SpellEffects.Effects.ATTACK_YOURSELF,
		UiCommon.despair_spell_texture
	)
	
	spells["despair"] = despair
	
	apathy.init(
		"Apathy",
		"Physic",
		"Force enemy to skip attack",
		SpellEffects.Effects.SKIP_ATTACK,
		UiCommon.apathy_spell_texture
	)
	
	spells["apathy"] = apathy
	
	insanity.init(
		"Insanity",
		"Physic",
		"Enemy will make random actions",
		SpellEffects.Effects.DO_RANDOM_ACTIONS,
		UiCommon.insanity_spell_texture
	)
	
	spells["insanity"] = insanity
	
	necromancy.init(
		"Necromancy",
		"Dark",
		"Revive ally",
		SpellEffects.Effects.REVIVE_ALLY,
		UiCommon.necromancy_spell_texture
	)
	
	spells["necromancy"] = necromancy
	
	decay.init(
		"Decay",
		"Dark",
		"Increase the absorbed damage",
		SpellEffects.Effects.DECREASE_MAGIC_DEFENSE,
		UiCommon.decay_spell_texture
	)
	
	spells["decay"] = decay
	
	roots.init(
		"Roots",
		"Elemental",
		"Decrease enemy's magic defense",
		SpellEffects.Effects.DECREASE_MAGIC_DEFENSE,
		UiCommon.roots_spell_texture
	)
	
	spells["roots"] = roots
	
	blindness.init(
		"Blindness",
		"Faith",
		"Increase the possibility to miss",
		SpellEffects.Effects.DECREASE_CONCENTRATION,
		UiCommon.blindness_spell_texture
	)
	
	spells["blindness"] = blindness
	
	divine_hammer.init(
		"Divine Hammer",
		"Faith",
		"Damage enemy",
		SpellEffects.Effects.DAMAGE,
		UiCommon.divine_hammer_spell_texture
	)
	
	spells["divine_hammer"] = divine_hammer
	
	selestial_support.init(
		"Selestial Support",
		"Faith",
		"Increase the magic defense",
		SpellEffects.Effects.INCREASE_MAGIC_DEFENSE,
		UiCommon.selestial_support_spell_texture
	)
	
	spells["selestial_support"] = selestial_support
	

func get_spell_by_name(spell_name: String) -> CharacterSpell:
	return spells.get(spell_name)
