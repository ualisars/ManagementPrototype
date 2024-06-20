extends TextureRect

@export_file("*.tscn") var scene_file
var parent_file_path

func open_scene():
	Messenger.NEW_SCENE_OPENED.emit(parent_file_path)
	
	var tween = create_tween()
	tween.tween_interval(0.1)
	tween.tween_callback(get_tree().change_scene_to_file.bind(scene_file))


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		open_scene()
