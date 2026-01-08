extends Strategy
class_name Majority

func _init():
	nam = "Majority"
	randomize()
func decide():
	if history_opponent.size() == 0:
		apply_noise("C")
	var c_count = 0
	var d_count = 0
	for move in history_opponent:
		if move == "C":
			c_count += 1
		else:
			d_count += 1
	if c_count >= d_count:
		return apply_noise("C")
	return apply_noise("D")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
