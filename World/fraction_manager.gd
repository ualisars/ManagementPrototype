extends Node

var fractions: Array

var keepers: Fraction
var chaos: Fraction
var seekers: Fraction
var inquisition: Fraction

func _ready():
	init_franctions()


func init_franctions() -> void:
	keepers = Fraction.new()
	keepers.init("Keepers of Order", 40, 20, 80)
	
	chaos = Fraction.new()
	chaos.init("Chaos", 40, 10, 0)
	
	seekers = Fraction.new()
	seekers.init("Seekers", 20, 10, 50)
	
	inquisition = Fraction.new()
	inquisition.init("Inquisition", 80, 80, 30)
	
	fractions.append(keepers)
	fractions.append(chaos)
	fractions.append(seekers)
	fractions.append(inquisition)
