extends TextureRect

var mage_number: int = 2

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var task_character_slot_1: Panel = $GridContainer/TaskCharacterSlot1
@onready var task_character_slot_2: Panel = $GridContainer/TaskCharacterSlot2
@onready var task_character_slot_3: Panel = $GridContainer/TaskCharacterSlot3
@onready var task_character_slot_4: Panel = $GridContainer/TaskCharacterSlot4
@onready var task_character_slot_5: Panel = $GridContainer/TaskCharacterSlot5
@onready var task_character_slot_6: Panel = $GridContainer/TaskCharacterSlot6

@onready var character_info_small_1: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall1
@onready var character_info_small_2: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall2
@onready var character_info_small_3: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall3
@onready var character_info_small_4: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall4
@onready var character_info_small_5: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall5
@onready var character_info_small_6: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall6
@onready var character_info_small_7: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall7
@onready var character_info_small_8: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall8
@onready var character_info_small_9: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall9
@onready var character_info_small_10: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall10
@onready var character_info_small_11: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall11
@onready var character_info_small_12: TextureRect = $PlayerCharacterScrollContainer/PlayerCharactersGridContainer/CharacterInfoSmall12




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
	for index in range(0, Player.party.size()):
		var characteristic: Characterictic = Player.party[index]
		var character_info_id: int = index + 1
		Messenger.INIT_CHARACTER_INFO.emit(character_info_id, characteristic)
