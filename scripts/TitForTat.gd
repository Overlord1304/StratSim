extends Strategy
class_name TitForTat

func _init():
	nam = "Tit for Tat"

func decide() -> String:
	if history_opponent.is_empty():
		return "C"
	return history_opponent.back()
