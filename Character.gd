extends Node

var health: int = 10
var attack: int = 2
var defense: int = 3
var price: int = 5

var rng = RandomNumberGenerator.new()

func init():
	health = rng.randf_range(8, 20)
	attack = rng.randf_range(4, 7)
	defense = rng.randf_range(1, 3)
	price = health + attack + defense


func _process(delta: float) -> void:
	pass
