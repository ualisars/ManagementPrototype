extends Node3D

@onready var distraction_spell_cast_particle = $DistractionSpellCastParticle

var owner_character: Character3D
var transition_amount

var elapsed_time: float = 0.0
var cast_speed: float = 4.0

var material: ShaderMaterial

func _ready():
	material = distraction_spell_cast_particle.material_override
	material.set_shader_parameter("TransitionAmount", 0.8)

func _process(delta):
	elapsed_time += delta
	
	transition_amount = elapsed_time / cast_speed
	
	transition_amount = min(transition_amount, 1.0)
	
	if transition_amount >= 1.0:
		set_process(false)

	material.set_shader_parameter("TransitionAmount", transition_amount)