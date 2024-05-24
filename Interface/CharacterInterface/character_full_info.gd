extends Control

var characteristics

var characteristics_container: GridContainer = GridContainer.new()

var attack_image: TextureRect = TextureRect.new()
var attack_value: Label = Label.new()

var defense_image: TextureRect = TextureRect.new()
var defense_value: Label = Label.new()

var health_image: TextureRect = TextureRect.new()
var health_value: Label = Label.new()

var concentration_image: TextureRect = TextureRect.new()
var concentration_value: Label = Label.new()

func init_characteristics_layout():
	UiCommon.add_image(attack_image, UiCommon.attack_texture_path, 40, 23, 5, 5)
	UiCommon.add_label(attack_value, 68, 23, 79, 6)
	
	UiCommon.add_image(defense_image, UiCommon.defense_texture_path, 40, 23, 5, 39)
	UiCommon.add_label(defense_value, 68, 23, 79, 39)
	
	UiCommon.add_image(health_image, UiCommon.health_texture_path, 40, 23, 5, 73)
	UiCommon.add_label(health_value, 68, 23, 79, 73)
	
	UiCommon.add_image(concentration_image, UiCommon.concentration_texture_path, 40, 23, 5, 107)
	UiCommon.add_label(concentration_value, 68, 23, 79, 107)

func init_characteristics(character_characteristics: Node) -> void:
	characteristics = character_characteristics

func init() -> void:
	characteristics_container.size.x = 268
	characteristics_container.size.y = 185
	characteristics_container.position.x = 0
	characteristics_container.position.y = 395
	
	characteristics_container.columns = 2
	
	attack_value.text = str(characteristics.attack)
	defense_value.text = str(characteristics.defense)
	health_value.text = str(characteristics.health)
	concentration_value.text = str(characteristics.concentration)
	
	characteristics_container.add_child(attack_image)
	characteristics_container.add_child(attack_value)
	
	characteristics_container.add_child(defense_image)
	characteristics_container.add_child(defense_value)
	
	characteristics_container.add_child(health_image)
	characteristics_container.add_child(health_value)
	
	characteristics_container.add_child(concentration_image)
	characteristics_container.add_child(concentration_value)
	
	add_child(characteristics_container)
