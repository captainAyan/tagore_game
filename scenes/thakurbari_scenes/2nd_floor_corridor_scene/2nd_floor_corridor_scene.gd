extends Node2D

func _ready():
	if LastSceneTracker.last_scene_name == "bedroom":
		$Player.position = Vector2(12528, 1400)
	elif LastSceneTracker.last_scene_name == "2nd_floor_corridor_3rd_floor_corridor_stairs":
		$Player.position = Vector2(1011, 1400)
	
	LastSceneTracker.last_scene_name = "2nd_floor_corridor"
