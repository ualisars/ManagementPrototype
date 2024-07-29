extends Spell3D


func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func on_area_entered(body: Node3D):
	if "id" in body and body.id == enemy_id:
		Messenger.SPELL_EFFECT_APPLIED.emit(owner_character, body, self)
		queue_free()

func _physics_process(delta: float) -> void:
	if owner_character.is_wounded:
		queue_free()

	position += direction * speed * delta
