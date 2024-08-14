extends Node3D

class_name SpellEffectParticle

var material: ShaderMaterial

var process_material: ParticleProcessMaterial

var current_scale: float

@export var total_duration: float

var spell3D: Spell3D

var elapsed_time: float = 0.0
var transition_amount: float = 0.0

func _process(delta):
	elapsed_time += delta

	transition_amount = lerp(0.0, 1.0, elapsed_time / total_duration)

	transition_amount = clamp(transition_amount, 0.0, 1.0)
	
	process_material.scale_min = transition_amount

	if transition_amount >= 1.0:
		set_process(false)
		queue_free()

	material.set_shader_parameter("TransitionAmount", transition_amount)
