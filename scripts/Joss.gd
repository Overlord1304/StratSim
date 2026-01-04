extends Strategy
class_name Joss
var defect_chance = 0.1
func _init():
	nam = "Joss"
	
func decide()->String:
	if history_opponent.is_empty():
		return "C"
	if randf() < defect_chance:
		return "D"
	return history_opponent.back()
