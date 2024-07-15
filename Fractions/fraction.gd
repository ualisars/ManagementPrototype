extends Node

class_name Fraction

var fraction_name: String
var power: int
var influence: int
var relationship: int
var task_weight: int
var provider_name: Task.TaskProvider

func _ready():
	pass
	

func init(
	init_name: String, 
	init_provider: Task.TaskProvider,
	init_power: int,
	init_influence: int, 
	init_relationship
) -> void:
	fraction_name = init_name
	provider_name = init_provider
	power = init_power
	influence = init_influence
	relationship = init_relationship

