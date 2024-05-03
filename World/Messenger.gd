extends Node

signal UNIT_HIRED(CharacterCharacteristics: Node)

signal PLAYER_INFO_UPDATED

signal UNIT_ATTACKED(attack_unit: Node, defend_unit: Node)

signal FIGHT_ENDED(is_player_win: bool)

signal FIGHT_STARTED

signal UNIT_PENETRATED(unit: Node3D, damage: int)
