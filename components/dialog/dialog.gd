extends CanvasLayer

signal dialog_over
signal entered

var current_dialog_index:int = 0

## Dialog script
var dialogs = []
@export_file var dialog_file

func _ready():
	var file = FileAccess.open(dialog_file, FileAccess.READ)
	var content = file.get_as_text()
	dialogs = JSON.parse_string(content)
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
		current_dialog_index = 0
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

func _show_dialog_at_index():
	$Label.text = dialogs[current_dialog_index]
