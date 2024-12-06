extends Node

var CharacteristicClass: PackedScene = preload("res://Characters/characteristic.tscn")

var gold: int = 100

var party: Array = []

func _ready() -> void:
	for i in range(2):
		var characteristic = CharacterGenerator.create_character(true)
		party.append(characteristic)

	Messenger.connect("UNIT_HIRED", on_character_hired)
	Messenger.SPELL_LEARNT.connect(on_spell_learnt)
	
	Messenger.CHARACTER_LEVEL_UP.connect(on_character_level_up)

func on_character_hired(characteristic: Node):
	gold -= characteristic.cost
	characteristic.add_belonging_to_player(true)
	party.append(characteristic)
	Messenger.PLAYER_INFO_UPDATED.emit()
	

func on_spell_learnt(spell: Node) -> void:
	var characteristics = GameManager.current_character_chosen_in_camp
	characteristics.learn_spell(spell)
	
func on_character_level_up(
	characteristics: Characterictic,
	update_characteristics_object: UpdateCharacteristicsObject
):
	characteristics.attack += update_characteristics_object.attack
	characteristics.defense += update_characteristics_object.defense
	characteristics.health += update_characteristics_object.health
	characteristics.cast_speed += update_characteristics_object.cast_speed
	characteristics.concentration += update_characteristics_object.concentration
	
	characteristics.available_level_ups -= 1
	
func add_gold(amount: int) -> void:
	gold += amount
