extends Node3D

var characteristics: Node

var attack: int
var defense: int
var health: int
var character_name: String
var is_player_controlled: bool
var cast_speed: int
var id: int
var is_belongs_to_player: bool

@onready var timer: Timer = $Timer

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

var SpellClass: PackedScene = preload("res://VFX/fireball_particle.tscn")

@onready var body: MeshInstance3D = $Body

func init(_characteristics: Node, player_controlled: bool) -> void:
	characteristics = _characteristics
	attack = characteristics.attack
	defense = characteristics.defense
	health = characteristics.health
	character_name = characteristics.character_name
	cast_speed = characteristics.cast_speed
	is_player_controlled = player_controlled
	id = characteristics.id
	is_belongs_to_player = characteristics.is_belongs_to_player

func _ready() -> void:
	Messenger.FIGHT_STARTED.connect(on_fight_started)
	
	Messenger.UNIT_ATTACKED.connect(on_unit_attacked)
	
	Messenger.UNIT_PENETRATED.connect(on_unit_penetrated)
	
	var material: StandardMaterial3D = StandardMaterial3D.new()
	
	if is_player_controlled:
		material.albedo_color = player_color
	else:
		material.albedo_color = enemy_color
		
	body.material_override = material
	
func on_fight_started():
	timer.wait_time = cast_speed
	timer.start()
	
func on_unit_attacked(attack_unit: Node, defend_unit: Node) -> void:
	if defend_unit.id == id and defend_unit.health <= 0:
		disable_unit()
	if attack_unit.id == id:
		var enemy = FightManager.get_character_3d_by_id(defend_unit.id)
		cast_spell(enemy)

func on_unit_penetrated(unit: Node3D, damage: int) -> void:
	if health <= 0:
		return

	if unit.id == id:
		health -= damage
		
	if health <= 0:
		disable_unit()
		FightManager.clear_wounded_character(unit)
		FightManager.check_win_loss_condition()
		

func disable_unit() -> void:
	timer.stop()
	body.rotate_z(90.0)


func cast_spell(enemy: Node3D):
	var spell = SpellClass.instantiate()
	add_child(spell)
	spell.enemy_id = enemy.id
	spell.global_position = global_position
	spell.damage = attack
	spell.direction = global_position.direction_to(enemy.global_position)


func _on_timer_timeout() -> void:
	if FightManager.check_enemy_exist(characteristics):
		var enemy: Node = FightManager.choose_enemy(characteristics)
		cast_spell(enemy)
