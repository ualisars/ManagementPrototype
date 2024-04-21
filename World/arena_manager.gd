extends Node


func generate_enemies() -> Array:
	var enemies: Array = []
	for i in range(4):
		var characteristics = CharacterGenerator.create_character(false)
		enemies.append(characteristics)
		
	return enemies
