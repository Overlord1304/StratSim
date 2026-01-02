extends Strategy
class_name GrimTrigger

var triggered = false

func _init():
	nam = "Grim Trigger"

func reset() -> void:
	super.reset()
	triggered = false

func decide() -> String:
	if "D" in history_opponent:
		triggered = true

	if triggered:
		return "D"
	else:
		return "C"
