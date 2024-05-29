extends TextureRect

@export var magic_school_name: String

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		Messenger.MAGIC_SCHOOL_ICON_CHOSEN.emit(magic_school_name)
