extends Node3D

var owner_character: Node3D 
var enemy_id: int
var speed: int = 3
var target_position: Vector3
var direction: Vector3
var damage: int

func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func on_area_entered(body: Node3D):
	if "id" in body and body.id == enemy_id:
		Messenger.CHARACTER_ATTACKED.emit(body, owner_character)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
