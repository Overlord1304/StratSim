extends Strategy
class_name WSLS

func _init():
	nam = "WSLS"

func decide()->String:
	if history_self.is_empty():
		return "C"
	var last_self = history_self.back()
	var last_opp = history_opponent.back()
	if (last_self =="C" and last_opp == "C") \
	or (last_self == "D" and last_opp == "C"):
		return last_self
	return "D" if last_self == "C" else "C"
