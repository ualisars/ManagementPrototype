extends Control


@onready var inquisition_power_value = $FractionListContainer/InquisitionFraction/StatsContainer/PowerValue
@onready var inquisition_relationship_value = $FractionListContainer/InquisitionFraction/StatsContainer/RelationshipValue

@onready var seekers_power_value = $FractionListContainer/SeekersFraction/StatsContainer/PowerValue
@onready var seekers_relationship_value = $FractionListContainer/SeekersFraction/StatsContainer/RelationshipValue

@onready var chaos_power_value = $FractionListContainer/ChaosFraction/StatsContainer/PowerValue
@onready var chaos_relationship_value = $FractionListContainer/ChaosFraction/StatsContainer/RelationshipValue

@onready var keepers_power_value = $FractionListContainer/KeepersOfOrderFraction/StatsContainer/PowerValue
@onready var keepers_relationship_value = $FractionListContainer/KeepersOfOrderFraction/StatsContainer/RelationshipValue

func _ready() -> void:
	inquisition_power_value.text = str(FractionManager.inquisition.power)
	inquisition_relationship_value.text = str(FractionManager.inquisition.relationship)
	
	seekers_power_value.text = str(FractionManager.seekers.power)
	seekers_relationship_value.text = str(FractionManager.seekers.relationship)
	
	chaos_power_value.text = str(FractionManager.chaos.power)
	chaos_relationship_value.text = str(FractionManager.chaos.relationship)
	
	keepers_power_value.text = str(FractionManager.keepers.power)
	keepers_relationship_value.text = str(FractionManager.keepers.relationship)
