extends TextureRect

@export_file("*.tscn") var scene_file
@export_file("*.tscn") var parent_file

var default_modulate = "a9a9a9"
var hover_modulate = "ffffff"

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	custom_minimum_size.x = 200
	custom_minimum_size.y = 200
	modulate = default_modulate


func on_hover_entered():
	modulate = hover_modulate
	

func on_hover_exited():
	modulate = default_modulate
	
func open_scene():
	Messenger.NEW_SCENE_OPENED.emit(parent_file)
	
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(scene_file))


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		open_scene()
