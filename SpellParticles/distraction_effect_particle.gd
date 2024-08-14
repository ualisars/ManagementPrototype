extends SpellEffectParticle

@onready var gpu_particles_3d = $GPUParticles3D

func _ready():
	material = gpu_particles_3d.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)
	
	process_material = gpu_particles_3d.process_material
