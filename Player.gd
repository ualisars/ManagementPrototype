extends Node

var CharacterCharacteristics: PackedScene = preload("res://Characters/character_characteristics.tscn")

var gold: int = 100

var party: Array = []

func _ready() -> void:
	for i in range(2):
		var characteristics = CharacterCharacteristics.instantiate()
		party.append(characteristics)

	Messenger.connect("UNIT_HIRED", on_character_hired)

func on_character_hired(character_characteristics: Node):
	gold -= character_characteristics.cost
	party.append(character_characteristics)
	Messenger.PLAYER_INFO_UPDATED.emit()
