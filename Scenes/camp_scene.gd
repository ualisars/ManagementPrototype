extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(10):
		var slot = CharacterInfoClass.instantiate()
		grid_container.add_child(slot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
