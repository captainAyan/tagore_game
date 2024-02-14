extends Node2D



func _on_janitor_state_changed_to_cleaning():
	print("cleaning")


func _on_janitor_state_changed_to_idle():
	print("idle")


func _on_janitor_state_changed_to_moving():
	print("moving")
