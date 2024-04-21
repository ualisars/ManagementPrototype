extends Node

var CharacteristicClass: PackedScene = preload("res://Characters/characteristic.tscn")

var gold: int = 100

var party: Array = []

func _ready() -> void:
	for i in range(2):
		var characteristic = CharacterGenerator.create_character(true)
		party.append(characteristic)

	Messenger.connect("UNIT_HIRED", on_character_hired)

func on_character_hired(characteristic: Node):
	gold -= characteristic.cost
	characteristic.add_belonging_to_player(true)
	party.append(characteristic)
	Messenger.PLAYER_INFO_UPDATED.emit()
