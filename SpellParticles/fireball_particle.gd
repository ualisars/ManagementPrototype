extends Spell3D

func _ready():
	super()
	
	connect("area_entered", on_area_entered)

func on_area_entered(body: Node3D):
	if "id" in body and body.id == enemy_id:
		for effect in spell.effects:
			Messenger.SPELL_EFFECTS_APPLIED.emit(
				owner_character,
				body,
				self
			)
		queue_free()
