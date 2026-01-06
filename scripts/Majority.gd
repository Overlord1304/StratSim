extends Strategy
class_name Majority

func _init():
	nam = "Majority"

func decide():
	if history_opponent.size() == 0:
		return "C"
	var c_count = 0
	var d_count = 0
	for move in history_opponent:
		if move == "C":
			c_count += 1
		else:
			d_count += 1
	if c_count >= d_count:
		return "C"
	return "D"
