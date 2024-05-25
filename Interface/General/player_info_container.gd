extends HBoxContainer

@onready var gold_amount: Label = $GoldAmount
@onready var back_button: Button = $BackButton

@export_file("*.tscn") var scene_file

func _ready() -> void:
	gold_amount.text = str(Player.gold)
	Messenger.connect("PLAYER_INFO_UPDATED", on_player_info_updated)
	back_button.scene_file = scene_file


func on_player_info_updated():
	gold_amount.text = str(Player.gold)
