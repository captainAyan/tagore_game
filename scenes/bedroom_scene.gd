extends Node2D

func _ready():
	if LastSceneTracker.last_scene_name == "2nd_floor_corridor":
		$Player.position = Vector2(7620, 400)
	
	$Player/CanvasLayer/ExitBedroomButton.hide();


func _on_exit_room_button_pressed():
	print("enter corridor");
	LastSceneTracker.last_scene_name = "bedroom";
	get_tree().change_scene_to_file("res://scenes/2nd_floor_corridor_scene.tscn");


func _on_corridor_door_area_2d_body_entered(body):
	$Player/CanvasLayer/ExitBedroomButton.show();


func _on_corridor_door_area_2d_body_exited(body):
	$Player/CanvasLayer/ExitBedroomButton.hide();
