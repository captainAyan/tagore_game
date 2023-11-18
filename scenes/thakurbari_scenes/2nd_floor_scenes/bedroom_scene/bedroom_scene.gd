extends Node2D

func _ready():
	if LastSceneTracker.last_scene_name == "" :
		$AnimationPlayer.play("wake_up_anim")
