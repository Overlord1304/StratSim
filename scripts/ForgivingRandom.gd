extends Strategy
class_name ForgivingRandom

var defect_count = 0

func _init():
	nam = "Forgiving Random"
	randomize()
func decide():
	if history_opponent.size() == 0:
		return apply_noise("C")
	if history_opponent.back() == "D":
		defect_count += 1
	else:
		defect_count = 0
	if defect_count >= 2:
		return apply_noise("C") if randi() % 2 == 0 else apply_noise("D")
	return apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
