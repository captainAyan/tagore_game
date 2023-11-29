extends Node2D

signal finding_next_target

enum State {IDLE, WATERING, MOVING}

var current_state = State.IDLE
var target_plant_trigger_position:Vector2
var target_plant_trigger_id:int


func set_target_plant_location(plant_trigger_position:Vector2, plant_trigger_id):
	current_state = State.MOVING
	target_plant_trigger_position = plant_trigger_position
	target_plant_trigger_id = plant_trigger_id
	
	print("target_plant_trigger_position ", target_plant_trigger_position)
	print("target_plant_trigger_id ", target_plant_trigger_id)

func _process(delta):
	if current_state == State.IDLE: # when the scene is loaded
		$AnimationPlayer.play("idle_anim")
		finding_next_target.emit()
	
	elif current_state == State.MOVING: 
		$AnimationPlayer.play("walk_anim", -1, 2, false)
		
		if position.x < target_plant_trigger_position.x:
			var velocity = Vector2.ZERO
			velocity.x += 200
			position += velocity * delta
			scale.x = 1
		
		elif position.x > target_plant_trigger_position.x:
			var velocity = Vector2.ZERO
			velocity.x += 200
			position -= velocity * delta
			scale.x = -1
	
	elif current_state == State.WATERING:
		$AnimationPlayer.play("watering_anim")

func _on_plant_finder_area_2d_area_entered(area):
	if area.is_in_group("plant_trigger") and area.ID == target_plant_trigger_id:
		current_state = State.WATERING

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "watering_anim":
		finding_next_target.emit()
