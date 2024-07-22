extends Spell3D

@onready var distraction_spell_cast_particle = $DistractionSpellCastParticle

var transition_amount

var elapsed_time: float = 0.0

var material: ShaderMaterial

func _ready():
	material = distraction_spell_cast_particle.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)

func _process(delta):
	elapsed_time += delta
	
	transition_amount = elapsed_time / cast_speed
	
	transition_amount = min(transition_amount, 1.0)
	
	if transition_amount >= 1.0:
		Messenger.SPELL_EFFECT_APPLIED.emit(owner_character, target_character, spell)
		queue_free()

	material.set_shader_parameter("TransitionAmount", transition_amount)
	
