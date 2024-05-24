extends Button

@export_file("*.tscn") var scene_file

func _on_pressed() -> void:
	var scene: PackedScene = load(scene_file)
	
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(scene))
