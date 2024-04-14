extends TextureRect

@export_file("*.tscn") var scene_file

var default_modulate = "a9a9a9"
var hover_modulate = "ffffff"

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	modulate = default_modulate


func on_hover_entered():
	modulate = hover_modulate
	

func on_hover_exited():
	modulate = default_modulate
	
func open_scene():
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(scene_file))
