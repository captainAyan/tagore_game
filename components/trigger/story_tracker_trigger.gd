extends Area2D

signal on_trigger_entered

## The storyline state in which the game needs to be for this trigger to run
@export var storyline_state:String

## The objective that will be completed when the trigger is entered
@export var objective_to_complete:String

## If checked, the objective shall be completed once the trigger is entered
@export var autocomplete_objective:bool = true


func _on_body_entered(body):
	if body.name == "Player":
		if StorylineTracker.get_current_state_name() == storyline_state \
		and not StorylineTracker.current_state_completed_objectives.has(objective_to_complete):
			on_trigger_entered.emit()
			
			if autocomplete_objective:
				StorylineTracker.complete_objective(objective_to_complete)
