extends HBoxContainer

@export_file("*.tscn") var parent_scene_file

@onready var gold_amount: Label = $GoldAmount
@onready var back_button: Button = $BackButton

@onready var fractions_icon: TextureRect = $FractionsIcon

func _ready() -> void:
	gold_amount.text = str(Player.gold)
	Messenger.connect("PLAYER_INFO_UPDATED", on_player_info_updated)
	
	fractions_icon.parent_file_path = parent_scene_file

func on_player_info_updated():
	gold_amount.text = str(Player.gold)
