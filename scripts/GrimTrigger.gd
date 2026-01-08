extends Strategy
class_name GrimTrigger

var triggered = false

func _init():
	nam = "Grim Trigger"
	randomize()
func reset() -> void:
	super.reset()
	triggered = false

func decide() -> String:
	if "D" in history_opponent:
		triggered = true

	if triggered:
		return apply_noise("D")
	else:
		return apply_noise("C")
func apply_noise(move):
	if randi() % 100 < Global.noise:
		return "D" if move == "C" else "C"
	return move
