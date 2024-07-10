extends VBoxContainer


func _ready() -> void:
	Messenger.MAGIC_SCHOOL_ICON_CHOSEN.connect(on_magic_school_icon_chosen)

func on_magic_school_icon_chosen(magic_school_name: String) -> void:
	print("magic school chosen: " + magic_school_name)
