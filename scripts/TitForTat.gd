extends Strategy
class_name TitForTat

func _init():
	nam = "Tit for Tat"
	randomize()
func decide() -> String:
	if history_opponent.is_empty():
		return apply_noise("C")
	return history_opponent.back()
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
