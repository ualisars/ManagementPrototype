extends Button

@export_file("*.tscn") var scene_file

func _on_pressed() -> void:
	var scene: PackedScene = load(scene_file)
	
	print(get_tree().root.get_children())
	var children = get_tree().root.get_children()
	var current_scene_name = get_parent().get_parent().name
	
	print("current scene", get_tree().current_scene)
	print("current scene name", current_scene_name)
	
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(scene))
	
	for added_scene in children:
		if added_scene.name == current_scene_name:
			get_tree().root.remove_child(added_scene)
