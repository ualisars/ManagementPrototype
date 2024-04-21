extends Timer

func _ready() -> void:
	Messenger.connect("FIGHT_ENDED", on_fight_ended)

func on_fight_ended(_is_player_win: bool):
	print("fight ended")
	stop()
