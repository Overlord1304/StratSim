extends Strategy
class_name RandomStrategy

func _init():
	nam = "Random"
func decide():
	if randi()%2 == 0:
		return "C"
	return "D"
