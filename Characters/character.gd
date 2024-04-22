extends Node3D

var attack: int
var defense: int
var health: int
var character_name: String
var is_player_controlled: bool
var id: int

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

@onready var body: MeshInstance3D = $Body

func init(characteristics: Node, player_controlled: bool) -> void:
	attack = characteristics.attack
	defense = characteristics.defense
	health = characteristics.health
	character_name = characteristics.character_name
	is_player_controlled = player_controlled
	id = characteristics.id

func _ready() -> void:
	Messenger.UNIT_ATTACKED.connect(on_unit_attacked)
	
	var material: StandardMaterial3D = StandardMaterial3D.new()
	
	if is_player_controlled:
		material.albedo_color = player_color
	else:
		material.albedo_color = enemy_color
		
	body.material_override = material
	
func on_unit_attacked(attack_unit: Node, defend_unit: Node) -> void:
	if defend_unit.id == id and defend_unit.health <= 0:
		disable_unit()
		
func disable_unit() -> void:
	body.rotate_z(90.0)
