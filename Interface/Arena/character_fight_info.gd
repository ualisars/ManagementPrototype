extends Panel

@onready var health_bar: ProgressBar = $HealthBar
@onready var character_name_label: Label = $CharacterNameLabel

var red: Color = Color.RED
var green: Color = Color.GREEN

var character_id: int

var max_health: int:
	set(new_health):
		max_health = new_health
		health_bar.max_value = new_health

var current_health: int:
	set(new_health): 
		current_health = new_health
		health_bar.value = current_health
		var color = red.lerp(green, float(current_health) / float(max_health))
		health_bar.modulate = color

func set_character_name(character_name: String) -> void:
	character_name_label.text = character_name

func set_character_id(_character_id: int) -> void:
	character_id = _character_id
	
func set_max_health(health: int) -> void:
	max_health = health

func _ready() -> void:
	health_bar.modulate = green
	Messenger.CHARACTER_PENETRATED.connect(on_character_penetrated)

func on_character_penetrated(character: Node3D) -> void:
	if character_id == character.id:
		current_health = character.health
