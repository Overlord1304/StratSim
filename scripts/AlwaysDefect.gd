extends Strategy
class_name AlwaysDefect

func _init():
	nam = "Always Defect"
	
func decide():
	return "D"
