extends Node2D

signal state_changed_to_idle
signal state_changed_to_moving
signal state_changed_to_watering

enum State {IDLE, WATERING, MOVING}

var current_state:State = State.IDLE
var target_plant_trigger_id:String

@onready var plant_triggers = self.get_tree().get_nodes_in_group("plant_trigger")

func _ready():
	select_target_and_move()

func _process(delta):
	if current_state == State.IDLE: # when the scene is loaded
		$AnimationPlayer.play("idle_anim", 1, 2, false)
	
	elif current_state == State.MOVING: 
		$AnimationPlayer.play("walk_anim", 1, 2, false)
		var velocity:Vector2 = Vector2.ZERO
		
		if self.position.x < get_plant_target(target_plant_trigger_id).position.x:
			velocity.x += 200
		else:
			velocity.x -= 200
		
		self.look_towards(get_plant_target(target_plant_trigger_id).position)
		
		self.position += velocity * delta
	
	elif current_state == State.WATERING:
		$AnimationPlayer.play("watering_anim", 1, 2, false)


func set_plant_target(id):
	print("NPC: TARGET PLANT TRIGGER ID ", id)
	target_plant_trigger_id = id


func get_plant_target(id) -> Area2D:
	for i in plant_triggers.size():
		if plant_triggers[i] and plant_triggers[i].id == id:
			return plant_triggers[i]
	return null


func _on_plant_finder_area_2d_area_entered(area):
	if area.is_in_group("plant_trigger") and area.id == target_plant_trigger_id:
		current_state = State.WATERING
		
		state_changed_to_watering.emit()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "watering_anim":
		select_target_and_move()


func select_target_and_move():
	var new_target_index = randi_range(0,plant_triggers.size()-1)
	
	if plant_triggers[new_target_index].id == target_plant_trigger_id: # make sure target is not the same
		print("NPC: FINDING PLANT TARGET AGAIN")
		new_target_index = wrapi(new_target_index-1, 0, plant_triggers.size())
	
	set_plant_target(plant_triggers[new_target_index].id)
	current_state = State.MOVING
	
	state_changed_to_moving.emit()


func look_towards(target_position:Vector2):
	if self.position.x < target_position.x:
		self.scale.x = 1
	else:
		self.scale.x = -1

func stop_moving():
	current_state = State.IDLE
	
	state_changed_to_idle.emit()

func start_moving():
	select_target_and_move()
