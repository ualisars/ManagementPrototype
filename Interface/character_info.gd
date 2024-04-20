extends Panel

var characteristics: Node

signal unit_hired(character_characteristics: Node)

var attack_image: TextureRect = TextureRect.new()
var attack_value: Label = Label.new()

var defense_image: TextureRect = TextureRect.new()
var defense_value: Label = Label.new()

var health_image: TextureRect = TextureRect.new()
var health_value: Label = Label.new()

var cast_speed_image: TextureRect = TextureRect.new()
var cast_speed_value: Label = Label.new()

var cost_image: TextureRect = TextureRect.new()
var cost_value: Label = Label.new()

var character_name: Label = Label.new()

var character_image: TextureRect = TextureRect.new()

var hire_button: Button = Button.new()



var attack_texture_path = "res://Images/stiletto(1).svg"
var defense_texture_path = "res://Images/shield.svg"
var cost_texture_path = "res://Images/two-coins(1).svg"
var health_texture_path = "res://Images/hearts.svg"
var character_texture_path =  "res://Images/cultist.svg"
var cast_speed_texture_path = "res://Images/gift-of-knowledge.svg"


func add_button(button: Button) -> void:
	button.text = "Hire"
	
	button.custom_minimum_size.x = 100
	button.custom_minimum_size.y = 40
	
	button.size.x = 100
	button.size.y = 40
	
	button.position.x = 80
	button.position.y = 190
	
	button.connect("pressed", on_hire_button_pressed)
	
func on_hire_button_pressed():
	Messenger.UNIT_HIRED.emit(characteristics)

func add_image(
	texture_rect: TextureRect, 
	texture_path: String,
	size_x: int,
	size_y: int,
	position_x: int,
	position_y: int
	) -> void:
	texture_rect.texture = load(texture_path)
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	texture_rect.size.x = size_x
	texture_rect.size.y = size_y
	
	texture_rect.position.x = position_x
	texture_rect.position.y = position_y
	

func add_label(
	label: Label,
	size_x: int,
	size_y: int,
	position_x: int,
	position_y: int
	) -> void:
	label.add_theme_font_size_override("FontSize", 24)
	
	label.size.x = size_x
	label.size.y = size_y
	
	label.position.x = position_x
	label.position.y = position_y

func init_layout() -> void:
	add_image(attack_image, attack_texture_path, 40, 23, 106, 17)
	add_label(attack_value, 68, 23, 176, 17)
	
	add_image(defense_image, defense_texture_path, 40, 23, 106, 51)
	add_label(defense_value, 68, 23, 176, 51)
	
	add_image(health_image, health_texture_path, 40, 23, 106, 83)
	add_label(health_value, 68, 23, 176, 84)
	
	add_image(cast_speed_image, cast_speed_texture_path, 40, 23, 106, 110)
	add_label(cast_speed_value, 68, 23, 176, 109)
	
	add_image(cost_image, cost_texture_path, 40, 40, 96, 140)
	add_label(cost_value, 68, 23, 146, 148)
	
	add_label(character_name, 129, 23, 20, 90)
	
	add_image(character_image, character_texture_path, 96, 82, 0, 0)
	
	add_button(hire_button)
	

func init(is_hirable: bool = true) -> void:
	init_layout()
	
	if not is_hirable:
		hire_button.visible = false
		cost_image.visible = false
		cost_value.visible = false
	
	add_child(attack_image)
	add_child(attack_value)
	
	add_child(defense_image)
	add_child(defense_value)
	
	add_child(health_image)
	add_child(health_value)
	
	add_child(cast_speed_image)
	add_child(cast_speed_value)
	
	add_child(cost_image)
	add_child(cost_value)
	
	add_child(character_name)
	add_child(character_image)
	add_child(hire_button)

func init_characteristics(character_characteristics: Node) -> void:
	characteristics = character_characteristics
	attack_value.text = str(character_characteristics.attack)
	defense_value.text = str(character_characteristics.defense)
	health_value.text = str(character_characteristics.health)
	cast_speed_value.text = str(character_characteristics.cast_speed)
	character_name.text = str(character_characteristics.character_name)
	cost_value.text = str(character_characteristics.cost)
