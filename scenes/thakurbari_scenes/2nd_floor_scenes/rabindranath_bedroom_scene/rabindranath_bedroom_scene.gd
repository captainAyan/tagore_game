extends Node2D

func _ready():
	if StorylineTracker.get_current_state_name() == "wakes_up":
		StorylineTracker.complete_objective("wakes_up")
#		$AnimationPlayer.play("wake_up_anim")
		
		$AfterWakeUpDialog.start() # testing
		dialog_start_side_effect() # testing


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "wake_up_anim":
		$AfterWakeUpDialog.start()
		dialog_start_side_effect()

func _on_found_missing_dialog_story_tracker_trigger_on_trigger_entered():
	$FoundMissingDialog.start()
	dialog_start_side_effect()

func _on_after_wake_up_dialog_dialog_over():
	dialog_stop_side_effect()

func _on_found_missing_dialog_dialog_over():
	dialog_stop_side_effect()


func dialog_start_side_effect():
	$Player.movable = false
	$Controller.hide()

func dialog_stop_side_effect():
	$Player.movable = true
	$Controller.show()

