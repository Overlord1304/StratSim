extends Control
var dialogue = [
	{"text": "Welcome to the help menu, this helps you understand the concept of the game."},
]
@onready var dialogue_box = $DialogueBox

func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
func _ready():
	$AudioStreamPlayer.play()
	var game = get_tree().get_first_node_in_group("game")
	game._load_save()
	if !Global.help_dialogue_seen:
		dialogue_box.start_dialogue(dialogue)
		Global.help_dialogue_seen = true
		game._save()
