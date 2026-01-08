extends Strategy
class_name Minority
var c_count = 0
var d_count = 0
func _init():
	nam = "Minority"
	randomize()
func decide():
	if history_opponent.size() == 0:
		return apply_noise("C")
	var c_count = 0
	var d_count = 0
	for move in history_opponent:
		if move == "C":
			c_count += 1
		else:
			d_count += 1

	if c_count >= d_count:
		return apply_noise("D")
	return apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
