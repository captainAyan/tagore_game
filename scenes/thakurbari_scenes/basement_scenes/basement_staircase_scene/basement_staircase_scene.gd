extends Node2D


func _ready():
	if StorylineTracker.is_state_completed("find_light"):
		$Player/Candle.show()


func _on_find_basement_door_story_tracker_trigger_on_trigger_entered():
	$FoundBasementDoorDialog.start()
	dialog_start_side_effect()


func _on_found_basement_door_dialog_dialog_over():
	dialog_stop_side_effect()
	$CorridorDoor.enter_door()


func dialog_start_side_effect():
	$Player.movable = false
	$Controller.hide()

func dialog_stop_side_effect():
	$Player.movable = true
	$Controller.show()
