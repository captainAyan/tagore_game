extends Area2D

## Label that will appear on the button
@export var button_label = ""

## The scene that will be loaded
@export_file var scene_file = ""

## Allows only spawning, doesn't allow entering
@export var oneWay:bool = false

@export var player:CharacterBody2D

func _ready():
	if !oneWay:
		$CanvasLayer/DoorEnterButton.text = button_label
	
	$CanvasLayer/DoorEnterButton.hide()
	
	# transporting the player to the front of the door
	if scene_file == LastSceneTracker.last_scene_name:
		player.position = Vector2(self.position.x, self.position.y)


func _on_body_entered(body):
	if !oneWay and body.name == player.name:
		$CanvasLayer/DoorEnterButton.show()


func _on_body_exited(body):
	if !oneWay and body.name == player.name:
		$CanvasLayer/DoorEnterButton.hide()


func _on_door_enter_button_pressed():
	if !oneWay:
		# setting the last scene to global LastSceneTracker
		LastSceneTracker.last_scene_name = get_tree().current_scene.scene_file_path
		# loading entering scene
		get_tree().change_scene_to_file(scene_file)
