extends Control

var CharacterInfoClass: PackedScene = preload("res://Interface/CharacterInterface/character_info.tscn")

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

func show_character_layout():
	for character in CharacterGenerator.academy_characters:
		var character_info = CharacterInfoClass.instantiate()
		
		character_info.init()
		character_info.init_characteristics(character)
		
		grid_container.add_child(character_info)

func find_character_info_by_character_id(character_id: int) -> Panel:
	if grid_container.get_child_count() == 0:
		return null

	for character_info in grid_container.get_children():
		if character_info.characteristics.id == character_id:
			return character_info

	return null

func _ready() -> void:
	show_character_layout()
	
	Messenger.connect("UNIT_HIRED", on_character_hired)
	

func on_character_hired(character_characteristics: Node):
	CharacterGenerator.remove_acamedy_character(character_characteristics)
	
	var character_info = find_character_info_by_character_id(character_characteristics.id)
	
	grid_container.remove_child(character_info)

