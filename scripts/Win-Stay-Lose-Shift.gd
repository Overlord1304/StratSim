extends Strategy
class_name WSLS

func _init():
	nam = "WSLS"
	randomize()
func decide()->String:
	if history_self.is_empty():
		return apply_noise("C")
	var last_self = history_self.back()
	var last_opp = history_opponent.back()
	if (last_self =="C" and last_opp == "C") \
	or (last_self == "D" and last_opp == "C"):
		return apply_noise(last_self)
	return apply_noise("D") if last_self == "C" else apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
