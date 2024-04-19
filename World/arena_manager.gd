extends Node



func generate_enemies() -> Array:
	var enemies: Array = []
	for i in range(4):
		var characteristics = CharacterGenerator.create_character()
		enemies.append(characteristics)
		
	return enemies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
