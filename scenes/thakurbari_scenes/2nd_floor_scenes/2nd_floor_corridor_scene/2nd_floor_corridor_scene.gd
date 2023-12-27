extends Node2D

# for Gardener NPC
@onready var plant_triggers = $PlantTriggers.get_children()
var next_plant_index:int = 0

func _ready():
	$Gardener.position.x = randi_range(1000, 9000) # spawn gardener at random position

func _on_gardener_finding_next_target():
	$Gardener.set_target_plant_location(plant_triggers[next_plant_index].position, next_plant_index)
	
	if next_plant_index < 3:
		next_plant_index = randi_range(3, 5)
	else:
		next_plant_index = randi_range(0, 2)


func _on_gardener_entered_dialog_trigger():
	if StorylineTracker.get_current_state_name() == "gardener_conversation":
		StorylineTracker.complete_objective("gardener_conversation")
		$Gardener.start_talking($Gardener.position)
		$Player.movable = false
		$Controller.hide()
		$GardenerDialog.start()


func _on_gardener_dialog_dialog_over():
	$Gardener.stop_talking()
	$Player.movable = true
	$Controller.show()
