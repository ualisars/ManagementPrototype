extends Node

var MAX_LEVEL: int = 10
var LEVEL_POINTS: Dictionary

func _ready():
	LEVEL_POINTS = {
		1: 1000,
		2: 1200,
		3: 1500,
		4: 1700,
		5: 1900,
		6: 2100,
		7: 2400,
		8: 2700,
		9: 3200,
		10: 4000
	}


func get_level_points(level: int) -> int:
	return LEVEL_POINTS[level]
