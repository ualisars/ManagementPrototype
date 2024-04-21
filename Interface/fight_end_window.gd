extends Control

@onready var after_fight_message: Label = $TextureRect/AfterFightMessage

var player_win_message: String = "Victory"
var player_loose_message: String = "Defeat"

func add_after_fight_message(is_player_win: bool) -> void:
	if is_player_win:
		after_fight_message.text = player_win_message
	else:
		after_fight_message.text = player_loose_message
