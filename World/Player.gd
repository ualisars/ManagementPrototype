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

func on_character_hired(characteristic: Node):
	gold -= characteristic.cost
	characteristic.add_belonging_to_player(true)
	party.append(characteristic)
	Messenger.PLAYER_INFO_UPDATED.emit()
	

func on_spell_learnt(spell: Node) -> void:
	var characteristics = GameManager.current_character_chosen_in_camp
	add_spell_to_charater(characteristics, spell)

func add_spell_to_charater(characteristics: Node, spell: Node) -> void:
	for character in party:
		if character.id == characteristics.id and not is_spell_learnt(spell, characteristics):
			character.learn_spell(spell)
			return
			
func is_spell_learnt(spell: Node, characteristics: Node) -> bool:
	for learnt_spell in characteristics.learnt_spells:
		if spell.spell_name == learnt_spell.spell_name:
			return true
	return false
