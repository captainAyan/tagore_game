@tool
extends Node2D

## Item image sprite
@export_file var sprite_file:String = ""
## Label that will appear in the button
@export var button_label:String = ""
## State in which the item is collectable
@export var collection_state:String = ""
## Objective that will be completed
@export var collection_objective:String = ""
## If checked, the item shall show even before the item collection state
@export var show_before_collection_state:bool = true

func _ready():
	$CanvasLayer/CollectionButton.text = button_label
	$CanvasLayer/CollectionButton.hide()
	
	$Sprite2D.texture = load(sprite_file)
	
	if StorylineTracker.get_current_state_name() == collection_state: # the collection state
		$Sprite2D.visible = not StorylineTracker.current_state_completed_objectives.has(collection_objective)
	else: # not the collection state
		if StorylineTracker.is_state_completed(collection_state): # collection is done
			$Sprite2D.hide()
		else: # collection state is yet to come
			$Sprite2D.visible = show_before_collection_state

func _process(delta):
	if sprite_file != "" and Engine.is_editor_hint():
		$Sprite2D.texture = load(sprite_file)

func _on_body_entered(body):
	if StorylineTracker.get_current_state_name() == collection_state \
	and not StorylineTracker.current_state_completed_objectives.has(collection_objective) \
	and body.name == "Player":
		$CanvasLayer/CollectionButton.show()


func _on_body_exited(body):
	$CanvasLayer/CollectionButton.hide()


func _on_collection_button_pressed():
	StorylineTracker.complete_objective(collection_objective)
	$CanvasLayer/CollectionButton.hide()
	$Sprite2D.hide()
