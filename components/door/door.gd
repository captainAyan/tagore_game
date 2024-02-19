extends Area2D

signal door_entered
signal tried_entering_locked_door

## Label that will appear on the button
@export var button_label:String = ""

## The scene that will be loaded
@export_file var scene_file:String = ""

## Allows only spawning, doesn't allow entering
@export var one_way:bool = false

## A Locked door will send tried_entering_locked_door signal (not change the scene)
@export var locked:bool = false

## Message displayed when trying to enter locked door
@export var locked_door_message = "The door is locked"

## The door button will only show up if the door is active
@export var is_active:bool = true

@export var player:CharacterBody2D

func _ready():
	$CanvasLayer/LockedDoorLabel.text = locked_door_message
	
	if !one_way:
		$CanvasLayer/DoorEnterButton.text = button_label
	
	$CanvasLayer/DoorEnterButton.hide()
	$CanvasLayer/LockedDoorLabel.hide()
	
	# transporting the player to the front of the door
	if scene_file == LastSceneTracker.last_scene_name:
		player.position = Vector2(self.position.x, self.position.y)


func _on_body_entered(body):
	if !one_way and body.name == player.name and is_active:
		$CanvasLayer/DoorEnterButton.show()


func _on_body_exited(body):
	if !one_way and body.name == player.name and is_active:
		$CanvasLayer/DoorEnterButton.hide()


func _on_door_enter_button_pressed():
	if !one_way:
		if !locked:
			enter_door()
		else:
			$CanvasLayer/LockedDoorLabel.show()
			$LockedDoorLableTimer.start()
			tried_entering_locked_door.emit()


func enter_door():
	door_entered.emit()
	# setting the last scene to global LastSceneTracker
	LastSceneTracker.last_scene_name = get_tree().current_scene.scene_file_path
	# loading entering scene
	get_tree().change_scene_to_file(scene_file)


func _on_locked_door_lable_timer_timeout():
	$CanvasLayer/LockedDoorLabel.hide()
