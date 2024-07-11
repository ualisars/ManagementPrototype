extends Node

var attack_texture_path = "res://Images/stiletto(1).svg"
var defense_texture_path = "res://Images/shield.svg"
var cost_texture_path = "res://Images/two-coins(1).svg"
var health_texture_path = "res://Images/hearts.svg"
var character_texture_path =  "res://Images/cultist.svg"
var concentration_texture_path = "res://Images/brainstorm.svg"
var cast_speed_texture_path = "res://Images/gift-of-knowledge.svg"

var current_full_character

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
	
	texture_rect.custom_minimum_size.x = 30
	texture_rect.custom_minimum_size.y = 10
	
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
	

func add_chosen_full_character(characteristics: Node):
	current_full_character = characteristics
