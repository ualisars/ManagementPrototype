extends TextureRect

var mage_number: int = 2

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var task_character_slot_1: Panel = $GridContainer/TaskCharacterSlot1
@onready var task_character_slot_2: Panel = $GridContainer/TaskCharacterSlot2
@onready var task_character_slot_3: Panel = $GridContainer/TaskCharacterSlot3
@onready var task_character_slot_4: Panel = $GridContainer/TaskCharacterSlot4
@onready var task_character_slot_5: Panel = $GridContainer/TaskCharacterSlot5
@onready var task_character_slot_6: Panel = $GridContainer/TaskCharacterSlot6

@onready var player_characters_grid_container: GridContainer = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer

func _ready() -> void:
	show_task_character_slots()
	
	show_character_layout()
		

func show_task_character_slots() -> void:
	var task_character_slots: Array = [
		task_character_slot_1,
		task_character_slot_2,
		task_character_slot_3,
		task_character_slot_4,
		task_character_slot_5,
		task_character_slot_6
	]
	
	for index in range(0, mage_number):
		var task_character_slot: Panel = task_character_slots[index]
		task_character_slot.visible = true
	
func show_character_layout():
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init()
		character_info.init_characteristics(character)
		
		player_characters_grid_container.add_child(character_info)
