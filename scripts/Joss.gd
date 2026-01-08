extends Strategy
class_name Joss
var defect_chance = 0.1
func _init():
	nam = "Joss"
	randomize()
func decide()->String:
	if history_opponent.is_empty():
		return apply_noise("C")
	if randf() < defect_chance:
		return apply_noise("D")
	return apply_noise(history_opponent.back())
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
