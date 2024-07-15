extends Node

var fractions: Array

var keepers: Fraction
var chaos: Fraction
var seekers: Fraction
var inquisition: Fraction

func _ready():
	init_franctions()


func init_franctions() -> void:
	if fractions.size() > 0:
		return
		
	var relationships = [0, 30, 40, 80, 20, 50]
	
	keepers = Fraction.new()
	keepers.init(
		"Keepers of Order",
		Task.TaskProvider.KEEPERS,
		randi_range(10, 90),
		20,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	chaos = Fraction.new()
	chaos.init(
		"Chaos",
		Task.TaskProvider.CHAOS,
		randi_range(10, 90),
		10,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	seekers = Fraction.new()
	seekers.init(
		"Seekers",
		Task.TaskProvider.SEEKERS,
		randi_range(10, 90),
		10,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	inquisition = Fraction.new()
	inquisition.init(
		"Inquisition",
		Task.TaskProvider.INQUISITION,
		randi_range(10, 90),
		80,
		relationships.pop_at(randi_range(0, relationships.size() - 1))
	)
	
	fractions.append(keepers)
	fractions.append(chaos)
	fractions.append(seekers)
	fractions.append(inquisition)
	

func get_providers_from_fractions() -> Array:
	if fractions.size() == 0:
		init_franctions()

	var task_fractions: Array = []
	
	var copied_fractions: Array = fractions.duplicate()
	
	for fraction: Fraction in copied_fractions:
		fraction.task_weight = fraction.relationship + int(fraction.power / 2)
	
	copied_fractions.sort_custom(func(a, b): return a.task_weight >= b.task_weight)
	
	var added_fractions: int = 0
	
	var diff = copied_fractions[0].task_weight - copied_fractions[1].task_weight
	if diff >= 30:
		task_fractions.append(copied_fractions[0])
		added_fractions += 1
	
	for index in range(0, copied_fractions.size()):
		if added_fractions == 3:
			break

		task_fractions.append(copied_fractions[index - 1])
		added_fractions += 1
		
	return task_fractions
	
	
	
