extends Button

@export var linked_activity_icon: Control


func _on_pressed() -> void:
	linked_activity_icon.open_scene()


func _on_mouse_entered() -> void:
	linked_activity_icon.on_hover_entered()


func _on_mouse_exited() -> void:
	linked_activity_icon.on_hover_exited()
