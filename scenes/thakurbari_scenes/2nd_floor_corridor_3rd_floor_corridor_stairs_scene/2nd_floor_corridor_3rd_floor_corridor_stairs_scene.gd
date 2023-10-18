extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if LastSceneTracker.last_scene_name == "3rd_floor_corridor":
		$Player.position = Vector2(5760, 1605)
	elif LastSceneTracker.last_scene_name == "2nd_floor_corridor":
		$Player.position = Vector2(450, 4360)
	LastSceneTracker.last_scene_name = "2nd_floor_corridor_3rd_floor_corridor_stairs";
