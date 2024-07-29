extends Control

var ArenaConsoleMessageClass = preload("res://Interface/Arena/arena_console_message.tscn")

@onready var console_message_container: VBoxContainer = $ScrollContainer/ConsoleMessageContainer

@onready var scroll_container: ScrollContainer = $ScrollContainer
var scroll_bar: ScrollBar

func _ready() -> void:
	scroll_bar = scroll_container.get_v_scroll_bar()
	Messenger.SPELL_EFFECT_APPLIED.connect(on_spell_effect_applied)

func on_spell_effect_applied(
	owner_character: Character3D, 
	target_character: Character3D,
	spell3d: Spell3D
):
	var arena_console_message = ArenaConsoleMessageClass.instantiate()
	
	console_message_container.add_child(arena_console_message)
	
	var owner_name: String = owner_character.character_name
	var target_name: String = target_character.character_name
	var damage: String = str(spell3d.calculate_damage())
	var health: String = str(target_character.health)
	var spell_name: String = spell3d.spell.spell_name
	var concentration: String = str(target_character.concentration)
	var console_text = ""
	match spell3d.spell.effect:
		SpellEffects.Effects.DAMAGE:
			console_text += owner_name + " dealt " + damage + " damage"
			console_text += " to " + target_name + ", "
			console_text += " cased by " + spell_name + " spell ."
			console_text += target_name + " has " + health + " health now."
		SpellEffects.Effects.DECREASE_CONCENTRATION:
			console_text += target_name + " is effected by "
			console_text += spell_name + " spell,"
			console_text += " concentration descreased by " + damage
			console_text += " and equals to " + concentration + " now."
		SpellEffects.Effects.ATTACK_ALLY:
			console_text += target_name + " is effected by "
			console_text += spell_name + " spell"
			console_text += " and forcing him to attack ally."
	
	arena_console_message.add_text(console_text)
	
	scroll_container.scroll_vertical = scroll_bar.max_value
