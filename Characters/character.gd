extends Node3D

var attack: int
var defense: int
var health: int
var character_name: String
var is_player_controlled: bool

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func init(characteristics: Node, player_controlled: bool) -> void:
	attack = characteristics.attack
	defense = characteristics.defense
	health = characteristics.health
	character_name = characteristics.character_name
	is_player_controlled = player_controlled


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh: MeshInstance3D = get_node("Body")
	
	if is_player_controlled:
		mesh.material_override.albedo_color = player_color
	else:
		mesh.material_override.albedo_color = enemy_color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
