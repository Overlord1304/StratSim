extends Strategy
class_name Tester
var opp_ret = false
func _init():
	nam = "Tester"

func _reset():
	super.reset()
	opp_ret = false

func decide():
	var round = history_self.size()
	if round == 0:
		return "D"
	if round == 1:
		return "C"
	
	if not opp_ret:
		if history_self[round - 2] == "C" and history_opponent[round-1] == "D":
			opp_ret = true
	if opp_ret:
		return history_opponent.back()
	return "D"
