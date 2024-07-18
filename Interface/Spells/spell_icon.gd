extends TextureRect

@export var spell_name: String

var spell: CharacterSpell


func _ready() -> void:
	spell = Spells.get_spell_by_name(spell_name)


func _on_mouse_entered() -> void:
	Messenger.SPELL_ICON_MOUSE_ENTERED.emit(spell.spell_name, spell.magic_school, spell.description)


func _on_mouse_exited() -> void:
	Messenger.SPELL_ICON_MOUSE_EXITED.emit()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		Messenger.SPELL_LEARNT.emit(spell)
