extends Node2D

func _ready():
	if LastSceneTracker.last_scene_name == "2nd_floor_corridor":
		$Player.position = Vector2(7620, 400)
	
	LastSceneTracker.last_scene_name = "bedroom";
