extends Panel

@onready var health_bar: ProgressBar = $HealthBar
@onready var character_name_label: Label = $CharacterNameLabel
var character_id: int

func set_character_name(character_name: String) -> void:
	character_name_label.text = character_name

func set_character_id(_character_id: int) -> void:
	character_id = _character_id
	
func set_max_health(health: int) -> void:
	health_bar.max_value = health

func set_current_health(current_health: int) -> void:
	health_bar.value = current_health
	
func _ready() -> void:
	Messenger.UNIT_ATTACKED.connect(on_character_attacked)

func on_character_attacked(attack_character: Node, defend_character: Node) -> void:
	if character_id == defend_character.id:
		set_current_health(defend_character.health)
