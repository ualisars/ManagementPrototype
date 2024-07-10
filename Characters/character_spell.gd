extends Node

class_name CharacterSpell

var spell_name: String
var description: String
var effects: String
var magic_school: String
var spell_texture: Texture2D

func init(
	_spell_name: String,
	_magic_school: String,
	_description: String,
	_spell_texture: Texture2D
) -> void:
	spell_name = _spell_name
	description = _description
	magic_school = _magic_school
	spell_texture = _spell_texture
