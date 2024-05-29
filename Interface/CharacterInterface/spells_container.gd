extends Control

@onready var physic_spells_container: GridContainer = $PhysicSpellsContainer
@onready var dark_spells_container: GridContainer = $DarkSpellsContainer
@onready var elemental_spells_container: GridContainer = $ElementalSpellsContainer
@onready var faith_spells_container: GridContainer = $FaithSpellsContainer

var current_spells_container: GridContainer
var current_school: String

func _ready() -> void:
	Messenger.MAGIC_SCHOOL_ICON_CHOSEN.connect(on_magic_school_icon_chosen)
	
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
