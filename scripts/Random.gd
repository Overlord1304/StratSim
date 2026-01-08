extends Strategy
class_name RandomStrategy

func _init():
	nam = "Random"
	randomize()
func decide():
	if randi()%2 == 0:
		return apply_noise("C")
	return apply_noise("D")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return apply_noise("D") if move == "C" else apply_noise("C")
	return move
