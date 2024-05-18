extends Panel

var characteristics: Node

@export_file("*.tscn") var scene_file

signal unit_hired(character_characteristics: Node)

var attack_image: TextureRect = TextureRect.new()
var attack_value: Label = Label.new()

var defense_image: TextureRect = TextureRect.new()
var defense_value: Label = Label.new()

var health_image: TextureRect = TextureRect.new()
var health_value: Label = Label.new()

var concentration_image: TextureRect = TextureRect.new()
var concentration_value: Label = Label.new()

var cost_image: TextureRect = TextureRect.new()
var cost_value: Label = Label.new()

var character_name: Label = Label.new()

var character_image: TextureRect = TextureRect.new()

var hire_button: Button = Button.new()

var is_hirable: bool = false


var attack_texture_path = "res://Images/stiletto(1).svg"
var defense_texture_path = "res://Images/shield.svg"
var cost_texture_path = "res://Images/two-coins(1).svg"
var health_texture_path = "res://Images/hearts.svg"
var character_texture_path =  "res://Images/cultist.svg"
var concentration_texture_path = "res://Images/brainstorm.svg"


func add_button(button: Button) -> void:
	button.text = "Hire"
	
	button.custom_minimum_size.x = 100
	button.custom_minimum_size.y = 40
	
	button.size.x = 100
	button.size.y = 40
	
	button.position.x = 80
	button.position.y = 190
	
	button.connect("pressed", on_hire_button_pressed)
	
func on_hire_button_pressed():
	Messenger.UNIT_HIRED.emit(characteristics)

func init_layout() -> void:
	UiCommon.add_image(attack_image, UiCommon.attack_texture_path, 40, 23, 106, 17)
	UiCommon.add_label(attack_value, 68, 23, 176, 17)
	
	UiCommon.add_image(defense_image, UiCommon.defense_texture_path, 40, 23, 106, 51)
	UiCommon.add_label(defense_value, 68, 23, 176, 51)
	
	UiCommon.add_image(health_image, UiCommon.health_texture_path, 40, 23, 106, 83)
	UiCommon.add_label(health_value, 68, 23, 176, 84)
	
	UiCommon.add_image(concentration_image, UiCommon.concentration_texture_path, 40, 23, 106, 110)
	UiCommon.add_label(concentration_value, 68, 23, 176, 109)
	
	UiCommon.add_image(cost_image, UiCommon.cost_texture_path, 40, 40, 96, 140)
	UiCommon.add_label(cost_value, 68, 23, 146, 148)
	
	UiCommon.add_label(character_name, 129, 23, 20, 90)
	
	UiCommon.add_image(character_image, UiCommon.character_texture_path, 96, 82, 0, 0)
	
	add_button(hire_button)
	

func init(_is_hirable: bool = true) -> void:
	init_layout()
	
	is_hirable = _is_hirable
	
	if not is_hirable:
		hire_button.visible = false
		cost_image.visible = false
		cost_value.visible = false
	
	add_child(attack_image)
	add_child(attack_value)
	
	add_child(defense_image)
	add_child(defense_value)
	
	add_child(health_image)
	add_child(health_value)
	
	add_child(concentration_image)
	add_child(concentration_value)
	
	add_child(cost_image)
	add_child(cost_value)
	
	add_child(character_name)
	add_child(character_image)
	add_child(hire_button)

func init_characteristics(character_characteristics: Node) -> void:
	characteristics = character_characteristics
	attack_value.text = str(character_characteristics.attack)
	defense_value.text = str(character_characteristics.defense)
	health_value.text = str(character_characteristics.health)
	concentration_value.text = str(character_characteristics.concentration)
	
	character_name.text = str(character_characteristics.character_name)
	cost_value.text = str(character_characteristics.cost)

func open_scene():
	var tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(get_tree().change_scene_to_file.bind(scene_file))

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and not is_hirable:
		open_scene()
