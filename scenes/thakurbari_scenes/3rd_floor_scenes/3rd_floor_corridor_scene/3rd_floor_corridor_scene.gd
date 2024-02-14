extends Node2D


func _ready():
	if StorylineTracker.is_state_completed("checking_rooms"):
		$Janitor.show()
		$Janitor.position.x = randi_range(1000, 9000)
	else:
		$Janitor.hide()
		$Janitor.stop_moving()


func _on_debendranath_bedroom_door_tried_entering_locked_door():
	if StorylineTracker.get_current_state_name() == "checking_rooms":
		StorylineTracker.complete_objective("try_check_debendranath_room")
		if StorylineTracker.get_current_state_name() == "janitor_conversation":
			$Janitor.show()
			$Janitor.position.x = randi_range(1000, 2000)
			$Janitor.start_moving()


func _on_story_tracker_trigger_on_trigger_entered():
	$Janitor.stop_moving()
	$Janitor.look_towards($Player.position)
	$JanitorDialog.start()
	dialog_start_side_effect()

func _on_janitor_dialog_dialog_over():
	$Janitor.start_moving()
	dialog_stop_side_effect()


func _on_justified_intrusion_story_tracker_trigger_on_trigger_entered():
	$JustifiedIntrusionDialog.start()
	dialog_start_side_effect()

func _on_justified_intrusion_dialog_dialog_over():
	dialog_stop_side_effect()


func dialog_start_side_effect():
	$Player.movable = false
	$Controller.hide()

func dialog_stop_side_effect():
	$Player.movable = true
	$Controller.show()


