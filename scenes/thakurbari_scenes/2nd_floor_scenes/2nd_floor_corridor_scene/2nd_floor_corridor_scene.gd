extends Node2D


func _ready():
	$Gardener.position.x = randi_range(1000, 9000) # spawn gardener at random position


func _on_story_tracker_trigger_on_trigger_entered():
	$Gardener.stop_moving()
	$Gardener.look_towards($Player.position)
	$GardenerDialog.start()
	dialog_start_side_effect()


func _on_gardener_dialog_dialog_over():
	$Gardener.start_moving()
	dialog_stop_side_effect()


func dialog_start_side_effect():
	$Player.movable = false
	$Controller.hide()

func dialog_stop_side_effect():
	$Player.movable = true
	$Controller.show()
