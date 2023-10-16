extends Node2D

func _ready():
	$Player/CanvasLayer/EnterBedroomButton.hide();


func _on_bedroom_door_area_2d_body_entered(body):
	$Player/CanvasLayer/EnterBedroomButton.show();


func _on_bedroom_door_area_2d_body_exited(body):
	$Player/CanvasLayer/EnterBedroomButton.hide();


func _on_enter_bedroom_button_pressed():
	print("enter bedroom")
	LastSceneTracker.last_scene_name = "2nd_floor_corridor"
	get_tree().change_scene_to_file("res://scenes/bedroom_scene.tscn")
