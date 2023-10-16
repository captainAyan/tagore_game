extends CanvasLayer

@export var level_name:String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelName.text = level_name
	pass # Replace with function body.

func _process(delta):
	pass
