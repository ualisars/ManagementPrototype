extends Node

var gold: int = 100

var party: Array = []

func _ready() -> void:
	Messenger.connect("UNIT_HIRED", on_character_hired)

func on_character_hired(character_characteristics: Node):
	gold -= character_characteristics.cost
	party.append(character_characteristics)
	Messenger.PLAYER_INFO_UPDATED.emit()
