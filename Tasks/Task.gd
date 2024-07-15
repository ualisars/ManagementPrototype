extends Node

class_name Task

enum ActionType {
	KILL
}

enum EnemyType {
	BRIGAND,
	VAMPIRE,
	WEREWOLF
}

enum TaskProvider {
	INQUISITION,
	CHAOS,
	KEEPERS,
	SEEKERS
}

var action: String
var enemy_type: String
var enemy_number: int
var mage_number: int
var provider_fraction: Fraction
var task_title: String
var image_path: String
var id: int
var task_number: int
var characters: Array = []
var bounty: int

func init(
	_action: ActionType, 
	_enemy_type: EnemyType,
	_enemy_number: int,
	_mage_number: int,
	_provider_fraction: Fraction,
	_image_path: String,
	_id: int,
	_task_number: int
	) -> void:
		action = ActionType.keys()[_action]
		enemy_type = EnemyType.keys()[_enemy_type]
		enemy_number = _enemy_number
		mage_number = _mage_number
		provider_fraction = _provider_fraction
		image_path = _image_path
		id = _id
		task_number = _task_number
		task_title = action + " " + str(enemy_number) + " " + enemy_type
		
		for index in range(enemy_number):
			var character: Characterictic = CharacterGenerator.create_character(false)
			characters.append(character)
			
		bounty = calculate_bounty()
			
func calculate_bounty() -> int:
	var bountry = 0
	for character: Characterictic in characters:
		bountry += round(character.cost / 2)
		
	return bountry
