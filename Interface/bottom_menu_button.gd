extends Button

@export var linked_activity_icon: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	pass


func _on_mouse_entered() -> void:
	linked_activity_icon.on_hover_entered()


func _on_mouse_exited() -> void:
	linked_activity_icon.on_hover_exited()
