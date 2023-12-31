extends Node2D

# for Gardener NPC
@onready var cleaning_triggers = $CleaningTriggers.get_children()
var next_cleaning_trigger_index:int = randi_range(0, 3)

func _ready():
	$Janitor.position.x = randi_range(1000, 9000) # spawn janitor at random position

func _on_janitor_finding_next_target():
	$Janitor.set_target_cleaning_location(cleaning_triggers[next_cleaning_trigger_index].position, next_cleaning_trigger_index)
	
	if next_cleaning_trigger_index < 2:
		next_cleaning_trigger_index = randi_range(2, 3)
	else:
		next_cleaning_trigger_index = randi_range(0, 1)


func _on_debendranath_bedroom_door_tried_entering_locked_door():
#	if key is in inventory: (pseudo code)
#		$DebendranathBedroomDoor.enter_door()
	pass


func _on_janitor_entered_dialog_trigger():
	if StorylineTracker.get_current_state_name() == "janitor_conversation":
		StorylineTracker.complete_objective("janitor_conversation")
		$Janitor.start_talking($Player.position)
		$Player.movable = false
		$Controller.hide()
		$JanitorDialog.start()


func _on_janitor_dialog_dialog_over():
	$Janitor.stop_talking()
	$Player.movable = true
	$Controller.show()
