extends Strategy
class_name ForgivingRandom

var defect_count = 0

func _init():
	nam = "Forgiving Random"

func decide():
	if history_opponent.size() == 0:
		return "C"
	if history_opponent.back() == "D":
		defect_count += 1
	else:
		defect_count = 0
	if defect_count >= 2:
		return "C" if randi() % 2 == 0 else "D"
	return "C"
