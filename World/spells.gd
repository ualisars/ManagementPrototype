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
	
	spells["fireball"] = fireball
	
	domination.init(
		"Domination",
		"Physic",
		"Force enemy to attack their ally",
		SpellEffects.Effects.ATTACK_ALLY,
		UiCommon.domination_spell_texture
	)
	
	spells["domination"] = domination
	
	distraction.init(
		"Distraction",
		"Physic",
		"Decrease enemy's concentration",
		SpellEffects.Effects.DECREASE_CONCENTRATION,
		UiCommon.distraction_spell_texture
	)
	
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
