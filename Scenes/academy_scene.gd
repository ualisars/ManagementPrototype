extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

func _ready() -> void:
	for i in range(10):
		var slot = CharacterInfoClass.instantiate()
		grid_container.add_child(slot)
