extends Node2D


func _ready():
	$Cat/AnimationPlayer.play("sleeping_anim")
	
	$BasementDoor.is_active = StorylineTracker.is_state_completed("janitor_conversation")
	if StorylineTracker.get_current_state_name() == "find_light":
		$BasementDoor.locked = true
