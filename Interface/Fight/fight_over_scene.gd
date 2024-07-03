extends Control


@export_file("*.tscn") var main_menu_scene_file


func move_to_main_menu():
	var tween = create_tween()
	tween.tween_interval(0.2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(main_menu_scene_file))


func _on_close_button_pressed():
	move_to_main_menu()
