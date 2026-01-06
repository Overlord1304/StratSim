extends CanvasLayer
class_name DialogueBox

@onready var dialogue_text = $Panel/DialogueText
@onready var next_button = $Panel/NextButton

var dialogue = []
var index = 0
var typing_speed = 0.03
var is_typing = false
var full_text = ""
func start_dialogue(lines):
	dialogue = lines
	index = 0
	show()
	_show_line()

func _show_line():
	if index >= dialogue.size():
		hide()
		return
	full_text = dialogue[index]["text"]
	dialogue_text.text = ""
	is_typing = true
	next_button.disabled = false
	await _type_text(full_text)
	is_typing = false
	next_button.disabled = false
func _type_text(text):
	for i in text.length():
		if not is_typing:
			break
		dialogue_text.text += text[i]
		await get_tree().create_timer(typing_speed).timeout
	dialogue_text.text = text
func _on_next_button_pressed() -> void:
	if is_typing:
		is_typing = false
		dialogue_text.text = full_text
		next_button.disabled = false
	else:
		index += 1
		_show_line()
