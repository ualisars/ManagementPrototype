extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/character_info.tscn")
var CharacterCharacteristics: PackedScene = preload("res://Characters/character_characteristics.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

func _ready() -> void:
	for i in range(5):
		var characteristics = CharacterCharacteristics.instantiate()
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init()
		character_info.init_characteristics(characteristics)
		
		grid_container.add_child(character_info)
