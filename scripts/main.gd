extends Node2D



func _on_button_button_up() -> void:
	$Panel/AnimationPlayer.play("close")
