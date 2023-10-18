extends Area2D

@export var button_label = ""
@export_file var scene_file = ""


func _ready():
	$CanvasLayer/DoorEnterButton.text = button_label
	$CanvasLayer/DoorEnterButton.hide()


func _on_body_entered(body):
	$CanvasLayer/DoorEnterButton.show()


func _on_body_exited(body):
	$CanvasLayer/DoorEnterButton.hide()


func _on_door_enter_button_pressed():
	get_tree().change_scene_to_file(scene_file)
