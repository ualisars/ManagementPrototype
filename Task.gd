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
	CITIZENS,
	INQUISITION
}

var action: String
var enemy_type: String
var enemy_number: int
var mage_number: int
var task_provider: String
var task_title: String
var image_path: String

func init(
	_action: ActionType, 
	_enemy_type: EnemyType,
	_enemy_number: int,
	_mage_number: int,
	_task_provider: TaskProvider,
	_image_path: String
	) -> void:
		action = ActionType.keys()[_action]
		enemy_type = EnemyType.keys()[_enemy_type]
		enemy_number = _enemy_number
		mage_number = _mage_number
		task_provider = TaskProvider.keys()[_task_provider]
		image_path = _image_path
		
		task_title = action + " " + str(enemy_number) + " " + enemy_type
