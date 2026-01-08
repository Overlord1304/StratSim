extends Strategy
class_name AlwaysCooperate

func _init():
	nam = "Always Cooperate"
	randomize()
func decide():
	return apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
