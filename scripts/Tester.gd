extends Strategy
class_name Tester
var opp_ret = false
func _init():
	nam = "Tester"
	randomize()
func _reset():
	super.reset()
	opp_ret = false

func decide():
	var round = history_self.size()
	if round == 0:
		return apply_noise("D")
	if round == 1:
		return apply_noise("C")
	
	if not opp_ret:
		if history_self[round - 2] == "C" and history_opponent[round-1] == "D":
			opp_ret = true
	if opp_ret:
		return apply_noise(history_opponent.back())
	return apply_noise("D")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
