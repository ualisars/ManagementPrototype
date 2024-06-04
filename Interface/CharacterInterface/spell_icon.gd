extends TextureRect

@export var spell_name: String
@export var spell_school: String
@export var spell_description: String



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	Messenger.SPELL_ICON_MOUSE_ENTERED.emit(spell_name, spell_school, spell_description)


func _on_mouse_exited() -> void:
	Messenger.SPELL_ICON_MOUSE_EXITED.emit()
