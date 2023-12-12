extends Node2D

func _ready():
	if StorylineTracker.get_current_state_name() == "wakes_up":
		StorylineTracker.complete_objective("wakes_up")
		$AnimationPlayer.play("wake_up_anim")
