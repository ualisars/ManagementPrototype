extends Node

class_name UpdateCharacteristicsObject

var attack: int
var defense: int
var health: int
var cast_speed: int
var concentration: int

func _init(
	new_attack: int, 
	new_defense: int, 
	new_health: int, 
	new_cast_speed: int,
	new_concentration: int
) -> void:
	attack = new_attack
	defense = new_defense
	health = new_health
	cast_speed = new_cast_speed
	concentration = new_concentration
