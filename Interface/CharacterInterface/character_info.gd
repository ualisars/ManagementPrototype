extends Panel

var characteristics: Node

var CharacterFullClass: PackedScene = preload("res://Interface/CharacterInterface/character_full_info.tscn")

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

var BUTTON_SIZE_LARGE = {
	"size_x": 100,
	"size_y": 40,
	"position_x": 80,
	"position_y": 190
}

func add_button(button: Button) -> void:
	button.text = "Hire"
	
	button.custom_minimum_size.x = BUTTON_SIZE_LARGE["size_x"]
	button.custom_minimum_size.y = BUTTON_SIZE_LARGE["size_y"]
	
	button.size.x = BUTTON_SIZE_LARGE["size_x"]
	button.size.y = BUTTON_SIZE_LARGE["size_y"]
	
	button.position.x = BUTTON_SIZE_LARGE["position_x"]
	button.position.y = BUTTON_SIZE_LARGE["position_y"]
	
	button.connect("pressed", on_hire_button_pressed)
	
func on_hire_button_pressed():
	Messenger.UNIT_HIRED.emit(characteristics)
	
func add_characteristic_layout(
	image: TextureRect, 
	texture_path: String,
	label: Label,
	position_y: int
):
	var image_size_x: int = 40
	var image_position_x: int = 106
	var size_y: int = 23
	var label_size_x: int = 68
	var label_position_x: int = 176
	
	
	UiCommon.add_image(
		image,
		texture_path,
		image_size_x,
		size_y,
		image_position_x,
		position_y
	)
	UiCommon.add_label(label, label_size_x, size_y, label_position_x, position_y)
	
	
func init_characteristics_layout():
	var image_size_x: int = 40
	var size_y: int = 23
	var label_size_x: int = 68
	
	var start_position_y: int = 17
	var offset_position_y: int = 34
	
	var data = [
		{
			"image": attack_image, 
			"texture_path": UiCommon.attack_texture_path,
			"label": attack_value
		},
		{
			"image": defense_image, 
			"texture_path": UiCommon.defense_texture_path,
			"label": defense_value
		},
		{
			"image": health_image, 
			"texture_path": UiCommon.health_texture_path,
			"label": health_value
		},
		{
			"image": concentration_image, 
			"texture_path": UiCommon.concentration_texture_path,
			"label": concentration_value
		}
	]
	
	var position_y = start_position_y
	
	for characteristic in data: 
		add_characteristic_layout(
			characteristic["image"], 
			characteristic["texture_path"], 
			characteristic["label"],
			position_y
		)
		
		position_y += offset_position_y

func init_layout() -> void:
	init_characteristics_layout()

	var image_size_x: int = 40
	var size_y: int = 23
	var label_size_x: int = 68
	
	UiCommon.add_image(
		cost_image, 
		UiCommon.cost_texture_path, 
		image_size_x, 
		40, 
		96, 
		140
	)
	UiCommon.add_label(cost_value, label_size_x, size_y, 146, 148)
	
	UiCommon.add_label(character_name, 129, size_y, 20, 90)
	
	UiCommon.add_image(
		character_image, 
		UiCommon.character_texture_path, 
		96, 
		82, 
		0, 
		0
	)
	
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
	Messenger.CHARACTER_INFO_CHOSEN.emit(characteristics)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and not is_hirable:
		open_scene()
