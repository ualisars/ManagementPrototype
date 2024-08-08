extends Node

signal UNIT_HIRED(CharacterCharacteristics: Node)

signal PLAYER_INFO_UPDATED

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

signal SPELL_LEARNT(spell: CharacterSpell)

signal NEW_SCENE_OPENED(scene_file_path: String)

signal INIT_CHARACTER_INFO(
	id: int, 
	characteristic: Characterictic, 
	task: Task,
	show_experience: bool
)

signal INIT_TASK_CONTAINER(task_number: int, task: Task)

signal TASK_OPENED(task: Task)

signal TASK_CLOSED()

signal CHARACTER_ADDED_TO_TASK(characteristic: Characterictic, task: Task)

signal CHARACTER_INFO_STATE_CHANGES(character_info_id: int)

signal TASK_FILLED(task: Task, characteristics: Array)

signal LEVEL_UP_OPENED(characteristic: Characterictic)

signal LEVEL_UP_CLOSED()

signal CHARACTER_LEVEL_UP(
	characteristics: Characterictic, 
	update_characteristics_object: UpdateCharacteristicsObject
)

signal SPELL_EFFECTS_APPLIED(
	owner_character: Character3D,
	target_character: Character3D,
	spell: Spell3D
)

signal CONCENTRATION_DESCREASED(character: Character3D)

signal SPELL_CANCELED(character3d: Character3D)

signal CONCENTRATION_CHANGED(character3d: Character3D)

signal DEFENSE_DECREASE_STARTED(character3d: Character3D, amount: int, effect_duration: float)

signal DEFENSE_DECREASE_ENDED(character3d: Character3D, amount: int)
