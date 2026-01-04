extends Control
class_name MoveBubble

@onready var bubble_a: Panel = $HBoxContainer/BubbleA
@onready var bubble_b: Panel = $HBoxContainer/BubbleB
@onready var label_a: Label = $HBoxContainer/BubbleA/Label
@onready var label_b: Label = $HBoxContainer/BubbleB/Label

const COLOR_C := Color(0.2, 0.8, 0.4)
const COLOR_D := Color(0.9, 0.3, 0.3)

func set_moves(a_move: String, b_move: String) -> void:
	label_a.text = a_move
	label_b.text = b_move

	circlifier(bubble_a, a_move)
	circlifier(bubble_b, b_move)

func circlifier(panel: Panel, move: String) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = COLOR_C if move == "C" else COLOR_D

	var radius := panel.custom_minimum_size.x / 2
	style.set_corner_radius_all(radius)

	panel.add_theme_stylebox_override("panel", style)
