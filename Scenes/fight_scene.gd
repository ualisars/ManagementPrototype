extends Node3D

@onready var fight_end_window: Control = $FightEndWindow
@onready var arena_sidebar: Control = $ArenaSidebar
@onready var arena_console: Control = $ArenaConsole


var player_characters_positions = [
	Vector3(-20.0, 0.0, -6.0),
	Vector3(-20.0, 0.0, -3.0),
	Vector3(-20.0, 0.0, 0.0),
	Vector3(-20.0, 0.0, 3.0),
	Vector3(-20.0, 0.0, 6.0),
	Vector3(-20.0, 0.0, 9.0),
]

var enemy_characters_positions = [
	Vector3(20.0, 0.0, -6.0),
	Vector3(20.0, 0.0, -3.0),
	Vector3(20.0, 0.0, 0.0),
	Vector3(20.0, 0.0, 3.0),
	Vector3(20.0, 0.0, 6.0),
	Vector3(20.0, 0.0, 9.0),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fight_end_window.visible = false

func place_characters() -> void:
	pass
