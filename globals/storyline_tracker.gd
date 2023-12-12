extends Node

const states = [
	{name = "wakes_up", objectives = ["wakes_up"]},
	{name = "found_missing", objectives = ["found_missing"]},
	{name = "gardener_conversation", objectives = ["gardener_conversation"]},
	{name = "justified_intrusion", objectives = ["justified_intrusion"]},
	{name = "checking_rooms", objectives = [
		"check_jyotirindranath_room",
		"check_abanindranath_room",
		"check_debendranath_room",
	]},
	{name = "janitor_conversation", objectives = ["janitor_conversation"]},
	{name = "find_basement_door", objectives = ["find_basement_door"]},
	{name = "find_light", objectives = ["find_light"]},
	{name = "find_key", objectives = ["find_key"]},
	{name = "enter_locked_room", objectives = ["enter_locked_room"]},
	{name = "find_evidence", objectives = ["find_evidence"]},
]

var current_state_index = 0
var current_state_completed_objectives = []

func complete_objective(objective):	
	if states[current_state_index].objectives.has(objective) and not current_state_completed_objectives.has(objective):
		current_state_completed_objectives.append(objective)
		print("STORYLINE TRACKER: OBJECTIVE FINISHED ", objective)
	
	if states[current_state_index].objectives.size() == current_state_completed_objectives.size():
		# all objectives completed
		current_state_index += 1
		current_state_completed_objectives = []
		print("STORYLINE TRACKER: STATE UPDATED ", states[current_state_index-1].name, " -> ", states[current_state_index].name)

func get_current_state_name():
	return states[current_state_index].name
