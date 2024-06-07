extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var grid_container: GridContainer = $CharactersContainer/GridContainer
@onready var character_full_info: Control = $CharacterFullInfo
@onready var player_info_container: HBoxContainer = $PlayerInfoContainer

@export_file("*.tscn") var current_scene_file
@export_file("*.tscn") var parent_scene_file

var CharacterFullInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_full_info.tscn")

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	Messenger.NEW_SCENE_OPENED.emit(parent_scene_file)
	
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init(false)
		character_info.init_characteristics(character)
		
		grid_container.add_child(character_info)
	
		
func on_character_info_chosen(_characteristics: Node):
	Messenger.NEW_SCENE_OPENED.emit(current_scene_file)
	
	grid_container.hide()
	character_full_info.show()
