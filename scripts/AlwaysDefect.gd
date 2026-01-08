extends Strategy
class_name AlwaysDefect

func _init():
	nam = "Always Defect"
	randomize()
func decide():
	return apply_noise("D")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
