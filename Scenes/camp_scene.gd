extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for character in Player.party:
		var character_info = CharacterInfoClass.instantiate()
		character_info.init_characteristics(character, false)
		
		grid_container.add_child(character_info)
