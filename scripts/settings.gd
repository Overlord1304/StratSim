extends Control
var saves = "user://save_data2.save"
func _load_save():
	if FileAccess.file_exists(saves):
		var file = FileAccess.open(saves, FileAccess.ModeFlags.READ)
		var data = file.get_var()
		$Panel/SpinBox.value = data.get("rounds", 50)
		$Panel/SpinBox2.value = data.get("speed",50)
		$Panel/SpinBox3.value = data.get("noise",0)
		
		file.close()

func _save():
	var file = FileAccess.open(saves, FileAccess.ModeFlags.WRITE)
	var data = {
		"rounds": $Panel/SpinBox.value,
		"speed": $Panel/SpinBox2.value,
		"noise": $Panel/SpinBox3.value,
	}
	file.store_var(data)
	file.close()
func _ready():
	_load_save()
	$AudioStreamPlayer.play()
func _on_back_button_up() -> void:
	_save()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(delta):
	Global.rounds = $Panel/SpinBox.value
	Global.speed = $Panel/SpinBox2.value
	Global.noise = $Panel/SpinBox3.value

func _on_spin_box_value_changed() -> void:
	_save()


func _on_spin_box_2_value_changed() -> void:
	_save()
