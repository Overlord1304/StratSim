extends Control
var default = false
func _ready():
	if !default:
		$Panel/SpinBox.value = 50
		default = true

func _on_back_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(delta):
	Global.rounds = $Panel/SpinBox.value
