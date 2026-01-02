extends Resource
class_name Strategy
var nam = "Base Strategy"
var history_self = []
var history_opponent = []

func reset():
	history_self.clear()
	history_opponent.clear()

func decide():
	return "C"

func record(my_move,opponent_move):
	history_self.append(my_move)
	history_opponent.append(opponent_move)
