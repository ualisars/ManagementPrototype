extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var grid_container: GridContainer = $CharactersContainer/GridContainer
@onready var character_full_info: Control = $CharacterFullInfo
@onready var player_info_container: HBoxContainer = $PlayerInfoContainer


var CharacterFullInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_full_info.tscn")

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init(false)
		character_info.init_characteristics(character)
		
		grid_container.add_child(character_info)
		
func on_character_info_chosen(_characteristics: Node):
	grid_container.hide()
	character_full_info.show()
	player_info_container.back_button.scene_file = "res://Scenes/camp_scene.tscn"
