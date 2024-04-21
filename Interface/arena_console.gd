extends Control

var ArenaConsoleMessageClass = preload("res://Interface/arena_console_message.tscn")

@onready var console_message_container: VBoxContainer = $ScrollContainer/ConsoleMessageContainer

func _ready() -> void:
	Messenger.connect("UNIT_ATTACKED", on_character_attacked)

func on_character_attacked(attack_character: Node, defend_character: Node):
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
