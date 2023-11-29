extends Node2D

# for Gardener NPC
@onready var plant_triggers = $PlantTriggers.get_children()
var next_plant_index = 0


func _on_gardener_finding_next_target():
	$Gardener.set_target_plant_location(plant_triggers[next_plant_index].position, next_plant_index)
	
	if next_plant_index < 4:
		next_plant_index = randi_range(4, 7)
	else:
		next_plant_index = randi_range(0, 3)
