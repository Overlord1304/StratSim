extends Strategy
class_name Alternator

func _init():
	nam = "Aternator"
func decide():
	if history_self.back() == "C":
		return "D"
	return "C"
