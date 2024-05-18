extends Node

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
