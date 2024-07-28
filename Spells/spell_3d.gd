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

@export var cast_usage_speed: float

func _ready():
	Messenger.SPELL_CANCELED.connect(on_spell_canceled)

func _process(delta):
	if owner_character.is_wounded:
		queue_free()
		
func on_spell_canceled(character3d: Character3D):
	if owner_character.id == character3d.id:
		queue_free()

func apply_spell_effect(enemy_character: Character3D):
	Messenger.SPELL_EFFECT_APPLIED.emit(
		owner_character,
		enemy_character,
		spell
	)
