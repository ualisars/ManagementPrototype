extends Control

@onready var characteristics: BoxContainer = $Background/Characteristics

var attack_image: TextureRect = TextureRect.new()
var attack_value: Label = Label.new()

var defense_image: TextureRect = TextureRect.new()
var defense_value: Label = Label.new()

var health_image: TextureRect = TextureRect.new()
var health_value: Label = Label.new()

var concentration_image: TextureRect = TextureRect.new()
var concentration_value: Label = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
