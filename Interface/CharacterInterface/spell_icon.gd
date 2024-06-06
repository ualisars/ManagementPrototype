extends TextureRect

@export var spell_name: String
@export var spell_school: String
@export var spell_description: String

var SpellClass: PackedScene = preload("res://Characters/character_spell.tscn")
var spell: Node = SpellClass.instantiate()


func _ready() -> void:
	spell.init(spell_name, spell_school, spell_description, texture)


func _on_mouse_entered() -> void:
	Messenger.SPELL_ICON_MOUSE_ENTERED.emit(spell_name, spell_school, spell_description)


func _on_mouse_exited() -> void:
	Messenger.SPELL_ICON_MOUSE_EXITED.emit()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		Messenger.SPELL_LEARNT.emit(spell)
