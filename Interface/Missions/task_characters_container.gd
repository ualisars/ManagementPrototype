extends TextureRect

var mage_number: int

var task_character_slots: Array

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var task_character_slot_1: Panel = $GridContainer/TaskCharacterSlot1
@onready var task_character_slot_2: Panel = $GridContainer/TaskCharacterSlot2
@onready var task_character_slot_3: Panel = $GridContainer/TaskCharacterSlot3
@onready var task_character_slot_4: Panel = $GridContainer/TaskCharacterSlot4
@onready var task_character_slot_5: Panel = $GridContainer/TaskCharacterSlot5
@onready var task_character_slot_6: Panel = $GridContainer/TaskCharacterSlot6

func _ready() -> void:
	Messenger.TASK_CHOSEN.connect(on_task_chosen)
	
	task_character_slots = [
		task_character_slot_1,
		task_character_slot_2,
		task_character_slot_3,
		task_character_slot_4,
		task_character_slot_5,
		task_character_slot_6
	]

func show_task_character_slots() -> void:
	for index in range(0, mage_number):
		var task_character_slot: Panel = task_character_slots[index]
		task_character_slot.visible = true
		

func show_character_layout() -> void:
	for index in range(0, Player.party.size()):
		var characteristic: Characterictic = Player.party[index]
		var character_info_id: int = index + 1
		Messenger.INIT_CHARACTER_INFO.emit(character_info_id, characteristic)
		
func on_task_chosen(task_mage_number: int):
	mage_number = task_mage_number
	
	show_task_character_slots()
	
	show_character_layout()

func init_container():
	for slot in task_character_slots:
		slot.visible = false


func _on_close_button_pressed() -> void:
	Messenger.TASK_CLOSED.emit()
	
	init_container()


func _on_accept_button_pressed() -> void:
	pass
