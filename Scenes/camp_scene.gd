extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

@onready var scroll_container: ScrollContainer = $ScrollContainer


var CharacterFullInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_full_info.tscn")

func _ready() -> void:
	Messenger.CHARACTER_INFO_CHOSEN.connect(on_character_info_chosen)
	
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init(false)
		character_info.init_characteristics(character)
		
		grid_container.add_child(character_info)
		
func on_character_info_chosen(characteristics: Node):
	grid_container.hide()
	
	var character_full_info = CharacterFullInfoClass.instantiate()
	character_full_info.init_characteristics(characteristics)
	character_full_info.init_characteristics_layout()
	character_full_info.init()
	
	scroll_container.add_child(character_full_info)

	
