extends Node2D


func _ready():
	$Cat/AnimationPlayer.play("sleeping_anim")
	
	if StorylineTracker.get_current_state_name() == "find_light":
		$BasementDoor.locked = true
