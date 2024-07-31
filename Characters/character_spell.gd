extends Node

class_name CharacterSpell

enum SpellInterationType {
	PROJECTILE,
	IMMATERIAL
}

var spell_name: String
var description: String
var effects: Array[SpellEffects.Effects]
var magic_school: String
var spell_texture: Texture2D
var spell_particle: PackedScene
var spell_effect_particle: PackedScene
var spell_position3d: Vector3
var spell_effect_position3d: Vector3
var spell_interaction_type: SpellInterationType

func init(
	_spell_name: String,
	_magic_school: String,
	_description: String,
	_effects: Array[SpellEffects.Effects],
	_spell_texture: Texture2D,
	_spell_interaction_type: SpellInterationType
) -> void:
	spell_name = _spell_name
	description = _description
	magic_school = _magic_school
	effects = _effects
	spell_texture = _spell_texture
	spell_interaction_type = _spell_interaction_type
	

func add_spell_particle(_spell_particle: PackedScene) -> void:
	spell_particle = _spell_particle
	
func add_spell_effect_particle(particle: PackedScene) -> void:
	spell_effect_particle = particle
	
func add_spell_position_3d(_spell_position3d: Vector3) -> void:
	spell_position3d = _spell_position3d
	
func add_spell_effect_position_3d(_spell_position3d: Vector3) -> void:
	spell_effect_position3d = _spell_position3d
