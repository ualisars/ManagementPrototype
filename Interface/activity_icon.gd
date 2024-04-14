extends TextureRect

var default_modulate = "a9a9a9"
var hover_modulate = "ffffff"

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	modulate = default_modulate


func on_hover_entered():
	modulate = hover_modulate
	

func on_hover_exited():
	modulate = default_modulate
