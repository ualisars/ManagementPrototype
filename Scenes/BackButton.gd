extends Button

var player_interface: PackedScene = load("res://Interface/player_interface.tscn")


func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(player_interface))
