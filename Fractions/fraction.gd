extends Node

class_name Fraction

var fraction_name: String
var power: int
var influence: int
var relationship: int


func _ready():
	pass
	

func init(init_name: String, init_power: int, init_influence: int, init_relationship) -> void:
	fraction_name = init_name
	power = init_power
	influence = init_influence
	relationship = init_relationship

