extends Control

var ArenaConsoleMessageClass = preload("res://Interface/Arena/arena_console_message.tscn")

@onready var console_message_container: VBoxContainer = $ScrollContainer/ConsoleMessageContainer

@onready var scroll_container: ScrollContainer = $ScrollContainer
var scroll_bar: ScrollBar

func _ready() -> void:
	scroll_bar = scroll_container.get_v_scroll_bar()
	Messenger.CHARACTER_ATTACKED.connect(on_character_attacked)

func on_character_attacked(attack_character: Node3D, defend_character: Node3D):
	var arena_console_message = ArenaConsoleMessageClass.instantiate()
	
	console_message_container.add_child(arena_console_message)
	
	var attack_name: String = attack_character.character_name
	var defend_name: String = defend_character.character_name
	var damage: String = str(attack_character.attack)
	var health: String = str(defend_character.health)
	
	var console_text = attack_name + " dealt " + damage + " damage"
	console_text += " to " + defend_name + ". "
	console_text += defend_name + " has " + health + " health now."
	
	arena_console_message.add_text(console_text)
	
	scroll_container.scroll_vertical = scroll_bar.max_value
