extends TextureRect

var current_task: Task

var task_character_slots: Array
var character_info_slots: Array

var character_info_ids = [101, 102, 103, 104, 105, 106]

var characters_added: int = 0

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var task_character_slot_1: Panel = $GridContainer/TaskCharacterSlot1
@onready var task_character_slot_2: Panel = $GridContainer/TaskCharacterSlot2
@onready var task_character_slot_3: Panel = $GridContainer/TaskCharacterSlot3
@onready var task_character_slot_4: Panel = $GridContainer/TaskCharacterSlot4
@onready var task_character_slot_5: Panel = $GridContainer/TaskCharacterSlot5
@onready var task_character_slot_6: Panel = $GridContainer/TaskCharacterSlot6

@onready var character_info_small_1: TextureRect = $GridContainer/CharacterInfoSmall1
@onready var character_info_small_2: TextureRect = $GridContainer/CharacterInfoSmall2
@onready var character_info_small_3: TextureRect = $GridContainer/CharacterInfoSmall3
@onready var character_info_small_4: TextureRect = $GridContainer/CharacterInfoSmall4
@onready var character_info_small_5: TextureRect = $GridContainer/CharacterInfoSmall5
@onready var character_info_small_6: TextureRect = $GridContainer/CharacterInfoSmall6

func _ready() -> void:
	Messenger.TASK_OPENED.connect(on_task_opened)
	Messenger.CHARACTER_ADDED_TO_TASK.connect(on_character_added_to_task)
	
	task_character_slots = [
		task_character_slot_1,
		task_character_slot_2,
		task_character_slot_3,
		task_character_slot_4,
		task_character_slot_5,
		task_character_slot_6
	]
	
	character_info_slots = [
		character_info_small_1,
		character_info_small_2,
		character_info_small_3,
		character_info_small_4,
		character_info_small_5,
		character_info_small_6,
	]

func show_task_character_slots() -> void:
	var character_info_index: int = 0
	
	for character_id in TaskManager.character_added_to_tasks:
		var character_to_task = TaskManager.character_added_to_tasks[character_id]
		
		var task: Task = character_to_task["task"]
		if task.id == current_task.id:
			var character_info_id = character_info_ids[character_info_index]
			var characteristic: Characterictic = character_to_task["character"]
			
			Messenger.INIT_CHARACTER_INFO.emit(
				character_info_id, 
				characteristic, 
				task
			)
			
			Messenger.CHARACTER_INFO_STATE_CHANGES.emit(character_info_id)
			
			characters_added += 1
			character_info_index += 1
			
	
	var free_slots: int = current_task.mage_number - characters_added
	
	for index in range(0, free_slots):
		var task_character_slot: Panel = task_character_slots[index]
		task_character_slot.visible = true
		

func show_character_layout() -> void:
	for index in range(0, Player.party.size()):
		var characteristic: Characterictic = Player.party[index]
		var character_info_id: int = index + 1
		Messenger.INIT_CHARACTER_INFO.emit(character_info_id, characteristic, current_task)
		
func on_task_opened(task: Task):
	current_task = task
	
	show_task_character_slots()
	
	show_character_layout()

func init_container():
	characters_added = 0
	
	for slot in task_character_slots:
		slot.visible = false
		
	for slot in character_info_slots:
		slot.visible = false


func _on_close_button_pressed() -> void:
	Messenger.TASK_CLOSED.emit()
	
	init_container()


func _on_accept_button_pressed() -> void:
	pass
	
func on_character_added_to_task(_characteristic: Characterictic, _task: Task) -> void:
	init_container()
	
	show_task_character_slots()
