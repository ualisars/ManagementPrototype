extends HBoxContainer

@onready var gold_amount: Label = $GoldAmount

func _ready() -> void:
	gold_amount.text = str(Player.gold)
	Messenger.connect("PLAYER_INFO_UPDATED", on_player_info_updated)


func on_player_info_updated():
	gold_amount.text = str(Player.gold)
