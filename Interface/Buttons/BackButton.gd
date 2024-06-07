extends Button

func _on_pressed() -> void:
	var scene_file = GameManager.last_scene_file_path
	var scene: PackedScene = load(scene_file)
	
	var tween = create_tween()
	tween.tween_interval(0.1)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(scene))
