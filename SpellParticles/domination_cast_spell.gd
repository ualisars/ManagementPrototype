extends Spell3D

@onready var gpu_particles_3d = $GPUParticles3D

var transition_amount

var elapsed_time: float = 0.0

var material: ShaderMaterial

var total_duration: float


func _ready():
	material = gpu_particles_3d.material_override
	material.set_shader_parameter("TransitionAmount", 0.0)
	
	total_duration = cast_usage_speed + cast_time


func _process(delta):
	elapsed_time += delta

	transition_amount = lerp(0.0, 1.0, elapsed_time / total_duration)

	transition_amount = clamp(transition_amount, 0.0, 1.0)

	if transition_amount >= 1.0:
		Messenger.SPELL_EFFECT_APPLIED.emit(owner_character, target_character, spell)
		set_process(false)
		queue_free()

	material.set_shader_parameter("TransitionAmount", transition_amount)
