extends Node3D

class_name Character3D

var characteristics: Characterictic

var attack: int
var defense: int
var health: int
var character_name: String
var is_player_controlled: bool
var cast_speed: int
var id: int
var is_belongs_to_player: bool

var is_wounded: bool = false

var damage_dealt: int = 0
var enemies_defeated: int = 0

@onready var timer: Timer = $Timer

var player_color: String = "5e4086"
var enemy_color: String = "fc4086"

var disabled: bool = false

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
	
	Messenger.CHARACTER_ATTACKED.connect(on_character_attacked)
	
	var material: StandardMaterial3D = StandardMaterial3D.new()
	
	if is_player_controlled:
		material.albedo_color = player_color
	else:
		material.albedo_color = enemy_color
		
	body.material_override = material
	
func on_fight_started():
	timer.wait_time = cast_speed
	timer.start()
	
func on_character_attacked(
	attack_character: Character3D, 
	defend_character: Character3D
) -> void:
	if defend_character.id != id:
		return
		
	var damage: int = attack_character.attack

	if health > 0:
		health -= damage
		Messenger.CHARACTER_PENETRATED.emit(defend_character)
		characteristics.add_dealt_damage(damage)
		
	if health <= 0 and not disabled:
		disable_unit()
		FightManager.clear_wounded_character(self)
		FightManager.check_win_loss_condition()
		
		characteristics.add_defeated_enemy()
		

func disable_unit() -> void:
	disabled = true
	is_wounded = true
	
	timer.stop()
	body.rotate_z(90.0)

func cast_spell(enemy: Node3D):
	var spell = SpellClass.instantiate()
	add_child(spell)
	spell.owner_character = self
	spell.enemy_id = enemy.id
	spell.global_position = global_position + Vector3(0, 1.2, 0)
	spell.damage = attack
	spell.direction = global_position.direction_to(enemy.global_position)

func _on_timer_timeout() -> void: 
	if FightManager.check_enemy_exist(characteristics):
		var enemy: Node = FightManager.choose_enemy(characteristics)
		cast_spell(enemy)
