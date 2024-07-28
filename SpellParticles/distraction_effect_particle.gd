extends Node3D

var elapsed_time: float = 0.0

var material: ShaderMaterial

var total_duration: float

var transition_amount: float

@onready var gpu_particles_3d = $GPUParticles3D

func _ready():
	material = gpu_particles_3d.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)
	
	total_duration = 4.2


func _process(delta):
	elapsed_time += delta

	transition_amount = lerp(0.0, 1.0, elapsed_time / total_duration)

	transition_amount = clamp(transition_amount, 0.0, 1.0)

	if transition_amount >= 1.0:
		set_process(false)
		queue_free()

	material.set_shader_parameter("TransitionAmount", transition_amount)
