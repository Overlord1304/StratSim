extends Control
var dialogue = [
	{"text": "Welcome to the strategy info menu, this helps you how the different strategies work."},

]
@export var enabled_dialogue = false
func _ready():
	if enabled_dialogue:

		var dialogue_box = $DialogueBox
		var game = get_tree().get_first_node_in_group("game")
		game._load_save()
		if !Global.strat_dialogue_seen:
			dialogue_box.start_dialogue(dialogue)
			Global.strat_dialogue_seen = true
			game._save()

func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_next_button_up() -> void:
	_change_stat_scene(1)

func _on_previous_button_up() -> void:
	_change_stat_scene(-1)

func _change_stat_scene(direction: int) -> void:
	var current_path = get_tree().current_scene.scene_file_path
	

	var start_index = -1
	var end_index = -1

	for i in range(current_path.length() - 1, -1, -1):
		var char_at = current_path[i]
		

		if char_at >= '0' and char_at <= '9':
			if end_index == -1:
				end_index = i
			start_index = i

		elif end_index != -1:
			break
	

	if start_index != -1 and end_index != -1:
		var number_str = current_path.substr(start_index, end_index - start_index + 1)
		var current_num = int(number_str)
		var next_num = current_num + direction
		var next_scene = current_path.substr(0, start_index) + str(next_num) + current_path.substr(end_index + 1)
		
		if FileAccess.file_exists(next_scene):
			get_tree().change_scene_to_file(next_scene)
