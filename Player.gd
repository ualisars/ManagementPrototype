extends Node

var gold: int = 100

var party: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func hire_character(character_characteristics: Node):
	gold -= character_characteristics.price
	party.append(character_characteristics)
