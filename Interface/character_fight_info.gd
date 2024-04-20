extends Panel

@onready var health_bar: ProgressBar = $HealthBar
@onready var character_name_label: Label = $CharacterNameLabel


func set_character_name(character_name: String) -> void:
	character_name_label.text = character_name
	
func set_max_health(health: int) -> void:
	health_bar.max_value = health

func set_current_health(current_health: int) -> void:
	health_bar.value = current_health
