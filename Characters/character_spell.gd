extends Node

class_name CharacterSpell

var spell_name: String
var description: String
var effect: SpellEffects.Effects
var magic_school: String
var spell_texture: Texture2D
var spell_particle: PackedScene
var spell_effect_particle: PackedScene
var spell_position3d: Vector3
var spell_effect_position3d: Vector3

func init(
	_spell_name: String,
	_magic_school: String,
	_description: String,
	_effect: SpellEffects.Effects,
	_spell_texture: Texture2D
) -> void:
	spell_name = _spell_name
	description = _description
	magic_school = _magic_school
	effect = _effect
	spell_texture = _spell_texture
	

func add_spell_particle(_spell_particle: PackedScene) -> void:
	spell_particle = _spell_particle
	
func add_spell_effect_particle(particle: PackedScene) -> void:
	spell_effect_particle = particle
	
func add_spell_position_3d(_spell_position3d: Vector3) -> void:
	spell_position3d = _spell_position3d
	
func add_spell_effect_position_3d(_spell_position3d: Vector3) -> void:
	spell_effect_position3d = _spell_position3d
