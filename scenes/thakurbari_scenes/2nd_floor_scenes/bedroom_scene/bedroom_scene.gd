extends Node2D

func _ready():
	if LastSceneTracker.last_scene_name == "" :
		$Player.movable = false
		$Controller.hide()
		$AnimationPlayer.play("wake_up_anim")
		await $AnimationPlayer.animation_finished
		$Player.movable = true
		$Controller.show()
