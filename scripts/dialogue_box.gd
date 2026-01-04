extends CanvasLayer
class_name DialogueBox

@onready var dialogue_text = $Panel/DialogueText
@onready var next_button = $Panel/NextButton

var dialogue = []
var index = 0

func start_dialogue(lines):
	dialogue = lines
	index = 0
	show()
	_show_line()

func _show_line():
	if index >= dialogue.size():
		hide()
		return
	dialogue_text.text = dialogue[index]["text"]


func _on_next_button_pressed() -> void:
	index += 1
	_show_line()
