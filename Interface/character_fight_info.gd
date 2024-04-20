extends Panel

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var character_name_label: Label = $CharacterNameLabel
var character_name: String

func set_character_name(character_name: String) -> void:
	character_name_label.text = character_name
