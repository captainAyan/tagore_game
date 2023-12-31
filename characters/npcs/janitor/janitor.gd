extends Node2D

signal finding_next_target
signal entered_dialog_trigger
signal exited_dialog_trigger

enum State {IDLE, CLEANING, MOVING, TALKING}

var current_state:State = State.IDLE
var target_cleaning_trigger_position:Vector2
var target_cleaning_trigger_id:int

func set_target_cleaning_location(cleaning_trigger_position:Vector2, cleaning_trigger_id):
	current_state = State.MOVING
	target_cleaning_trigger_position = cleaning_trigger_position
	target_cleaning_trigger_id = cleaning_trigger_id
	
	print("target_cleaning_trigger_position ", target_cleaning_trigger_position)
	print("target_cleaning_trigger_id ", target_cleaning_trigger_id)


func _process(delta):
	if current_state == State.IDLE: # when the scene is loaded
		$AnimationPlayer.play("idle_anim", 1, 2, false)
		finding_next_target.emit()
	
	elif current_state == State.MOVING: 
		$AnimationPlayer.play("walk_anim", 1, 2, false)
		var velocity:Vector2 = Vector2.ZERO
		
		if position.x < target_cleaning_trigger_position.x:
			velocity.x += 200
			scale.x = 1
		else:
			velocity.x -= 200
			scale.x = -1
		
		position += velocity * delta
	
	elif current_state == State.CLEANING:
		$AnimationPlayer.play("clean_anim", 1, 2, false)
	
	elif current_state == State.TALKING:
		$AnimationPlayer.play("idle_anim", 1, 2, false)


func _on_clearning_location_finder_area_2d_area_entered(area):
	if area.is_in_group("cleaning_trigger") and area.ID == target_cleaning_trigger_id:
		current_state = State.CLEANING


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "clean_anim":
		finding_next_target.emit()

func start_talking(player_position:Vector2):
	if current_state != State.TALKING:
		current_state = State.TALKING
		if position.x > player_position.x:
			scale.x = -1
		else:
			scale.x = 1

func stop_talking():
	finding_next_target.emit()


func _on_dialog_trigger_area_2d_body_entered(body):
	if body.name == "Player":
		entered_dialog_trigger.emit()


func _on_dialog_trigger_area_2d_body_exited(body):
	if body.name == "Player":
		exited_dialog_trigger.emit()
