extends Control

@onready var physic_spells_container: GridContainer = $PhysicSpellsContainer
@onready var dark_spells_container: GridContainer = $DarkSpellsContainer
@onready var elemental_spells_container: GridContainer = $ElementalSpellsContainer
@onready var faith_spells_container: GridContainer = $FaithSpellsContainer

@onready var spell_info_container: ColorRect = $SpellInfoContainer
@onready var spell_name_label: Label = $SpellInfoContainer/SpellName
@onready var spell_school_value: Label = $SpellInfoContainer/SpellSchoolValue
@onready var spell_description_label: Label = $SpellInfoContainer/SpellDescription


var current_spells_container: GridContainer
var current_school: String
var current_spell: String

func _ready() -> void:
	Messenger.MAGIC_SCHOOL_ICON_CHOSEN.connect(on_magic_school_icon_chosen)
	Messenger.SPELL_ICON_MOUSE_ENTERED.connect(on_spell_icon_mouse_entered)
	Messenger.SPELL_ICON_MOUSE_EXITED.connect(on_spell_icon_mouse_exited)
	
	current_spells_container = physic_spells_container
	current_school = "physic"

func on_magic_school_icon_chosen(magic_school_name: String) -> void:
	if current_school == magic_school_name:
		return
	
	current_spells_container.hide()
	
	current_school = magic_school_name
	
	match current_school:
		"physic":
			current_spells_container = physic_spells_container
		"dark":
			current_spells_container = dark_spells_container
		"elemental":
			current_spells_container = elemental_spells_container
		"faith":
			current_spells_container = faith_spells_container
			
	current_spells_container.show()
	
	print("magic school chosen: " + magic_school_name)
	
func on_spell_icon_mouse_entered(
	spell_name: String, 
	spell_school: String, 
	spell_description: String
):
	spell_info_container.show()
	spell_name_label.text = spell_name
	spell_school_value.text = spell_school
	spell_description_label.text = spell_description
	
	var mouse_position: Vector2 = get_local_mouse_position()
	
	spell_info_container.position = mouse_position
	
func on_spell_icon_mouse_exited():
	spell_info_container.hide()
