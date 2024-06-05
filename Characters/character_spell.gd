extends Node

var spell_name: String
var description: String
var effects: String
var magic_school: String

func init(
	_spell_name: String,
	_magic_school: String,
	_description: String
) -> void:
	spell_name = _spell_name
	description = _description
	magic_school = _magic_school
