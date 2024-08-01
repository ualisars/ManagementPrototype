extends Spell3D

@onready var gpu_particles_3d = $GPUParticles3D

func _ready():
	super()
	
	material = gpu_particles_3d.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)
	
	total_duration = cast_usage_speed + cast_time
