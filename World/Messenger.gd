extends Node

signal UNIT_HIRED(CharacterCharacteristics: Node)

signal PLAYER_INFO_UPDATED

signal CHARACTER_ATTACKED(attack_character: Node3D, defend_character: Node3D)

signal FIGHT_ENDED(is_player_win: bool)

signal FIGHT_STARTED

signal CHARACTER_PENETRATED(character: Node3D)

signal CHARACTER_INFO_CHOSEN(CharacterCharacteristics: Node)

signal MAGIC_SCHOOL_ICON_CHOSEN(magic_school_name: String)

signal SPELL_ICON_MOUSE_ENTERED(
	spell_name: String, 
	spell_school: String,
	spell_description: String
)

signal SPELL_ICON_MOUSE_EXITED

signal SPELL_LEARNT(spell: Node)

signal NEW_SCENE_OPENED(scene_file_path: String)

signal INIT_CHARACTER_INFO(id: int, characteristic: Characterictic, task: Task)

signal INIT_TASK_CONTAINER(task_number: int, task: Task)

signal TASK_OPENED(task: Task)

signal TASK_CLOSED()

signal CHARACTER_ADDED_TO_TASK(characteristic: Characterictic, task: Task)

signal CHARACTER_INFO_STATE_CHANGES(character_info_id: int)

signal TASK_FILLED(task: Task, characteristics: Array)

signal FIGHT_RESULT_CREATED(
	task: Task,
	player_characters3d: Array,
	enemy_characters3d: Array,
	is_player_win: bool
)
