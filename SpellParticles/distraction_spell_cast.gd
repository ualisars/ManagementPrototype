extends Spell3D

@onready var distraction_spell_cast_particle = $DistractionSpellCastParticle

func _ready():
	super()
	
	material = distraction_spell_cast_particle.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)
	
	total_duration = cast_usage_speed + cast_time
