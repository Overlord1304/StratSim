extends Strategy
class_name Alternator

func _init():
	nam = "Aternator"
	randomize()
func decide():
	if history_self.is_empty():
		return apply_noise("C")
	if history_self.back() == "C":
		return apply_noise("D")
	return apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
