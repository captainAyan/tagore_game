extends CanvasLayer

signal dialog_over

var current_dialog_index = 0
var dialogs:PackedStringArray

func _ready():
	self.hide()

func start():
	self.show()
	_show_dialog_at_index()
	_set_button_disabilities()

func _on_previous_dialog_button_pressed():
	current_dialog_index -= 1
	_show_dialog_at_index()
	_set_button_disabilities()

func _on_next_dialog_button_pressed():
	if current_dialog_index == dialogs.size() - 1: # on last dialog, 'next' is used as exit
		self.hide()
		dialog_over.emit()
	else:
		current_dialog_index += 1
		_show_dialog_at_index()
		_set_button_disabilities()

func _set_button_disabilities():
	if current_dialog_index == 0:
		$PreviousDialogButton.disabled = true
	else:
		$PreviousDialogButton.disabled = false
	
#	if dialogs.size()-1 == current_dialog_index:
#		$NextDialogButton.disabled = true
#	else:
#		$NextDialogButton.disabled = false

func _show_dialog_at_index():
	$Label.text = dialogs[current_dialog_index]
