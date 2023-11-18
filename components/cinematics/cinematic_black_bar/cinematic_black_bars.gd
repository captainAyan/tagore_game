extends CanvasLayer

func add_bar():
	$AnimationPlayer.play("enter_bar_anim")

func remove_bar():
	$AnimationPlayer.play("exit_bar_anim")
