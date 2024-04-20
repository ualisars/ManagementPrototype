extends Node


func generate_enemies() -> Array:
	var enemies: Array = []
	for i in range(4):
		var characteristics = CharacterGenerator.create_character()
		enemies.append(characteristics)
		
	return enemies
