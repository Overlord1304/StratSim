extends Control

func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
func _on_next_button_up() -> void:
	var current_scene = get_tree().current_scene.scene_file_path
	var regex = RegEx.new()
	regex.compile("(\\d+)")
	var result = regex.search(current_scene)
	var current_statinfo_num = int(result.get_string())
	var next_statinfo_num = current_statinfo_num + 1
	var next_scene = current_scene.replace(
		str(current_statinfo_num),
		str(next_statinfo_num),
	)
	get_tree().change_scene_to_file(next_scene)


func _on_previous_button_up() -> void:
	var current_scene = get_tree().current_scene.scene_file_path
	var regex = RegEx.new()
	regex.compile("(\\d+)")
	var result = regex.search(current_scene)
	var current_statinfo_num = int(result.get_string())
	var next_statinfo_num = current_statinfo_num - 1
	var next_scene = current_scene.replace(
		str(current_statinfo_num),
		str(next_statinfo_num),
	)
	get_tree().change_scene_to_file(next_scene)
