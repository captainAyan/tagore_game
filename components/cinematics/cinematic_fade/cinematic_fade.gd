extends CanvasLayer

func fade_to_black():
	$AnimationPlayer.play("fade_to_black_anim")

func fade_to_transparent():
	$AnimationPlayer.play("fade_to_transparent_anim")

func fade_out_and_in():
	$AnimationPlayer.play("fade_out_and_in_anim")

func black_screen():
	$AnimationPlayer.play("black_screen_anim")

func transparent_screen():
	$AnimationPlayer.play("transparent_screen_anim")
