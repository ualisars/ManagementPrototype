extends Node

signal UNIT_HIRED(CharacterCharacteristics: Node)

signal PLAYER_INFO_UPDATED

signal CHARACTER_ATTACKED(attack_character: Node3D, defend_character: Node3D)

signal FIGHT_ENDED(is_player_win: bool)

signal FIGHT_STARTED

signal CHARACTER_PENETRATED(character: Node3D)

signal CHARACTER_INFO_CHOSEN(CharacterCharacteristics: Node)
