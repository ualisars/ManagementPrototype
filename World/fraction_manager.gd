extends Node

var fractions: Array

var keepers: Fraction
var chaos: Fraction
var seekers: Fraction
var inquisition: Fraction

func _ready():
	init_franctions()


func init_franctions() -> void:
	var relationships = [0, 30, 40, 80, 20, 50]
	
	keepers = Fraction.new()
	keepers.init(
		"Keepers of Order",
		randi_range(10, 90),
		20,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	chaos = Fraction.new()
	chaos.init(
		"Chaos",
		randi_range(10, 90),
		10,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	seekers = Fraction.new()
	seekers.init(
		"Seekers",
		randi_range(10, 90),
		10,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	inquisition = Fraction.new()
	inquisition.init(
		"Inquisition",
		randi_range(10, 90),
		80,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	fractions.append(keepers)
	fractions.append(chaos)
	fractions.append(seekers)
	fractions.append(inquisition)
