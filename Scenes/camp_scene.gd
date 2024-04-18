extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

func _ready() -> void:
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init(false)
		character_info.init_characteristics(character)
		
		grid_container.add_child(character_info)
