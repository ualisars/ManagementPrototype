extends Node

class_name CharacterSpell

var spell_name: String
var description: String
var effect: SpellEffects.Effects
var magic_school: String
var spell_texture: Texture2D
var spell_particle: PackedScene

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
