extends Control
class_name Match
@onready var round_label = $Label
@onready var end_button = $Button

var s1
var s2
var match_result
const payoff = {
	"C,C": [3,3],
	"C,D": [0,5],
	"D,C": [5,0],
	"D,D": [1,1]
}
func run_match(a,b,rounds)->Dictionary:
	a.reset()
	b.reset()
	var score_a = 0
	var score_b = 0
	var log = []
	
	for i in range(rounds):
		var move_a = a.decide()
		var move_b = b.decide()
		
		var result = payoff["%s,%s"%[move_a,move_b]]
		score_a += result[0]
		score_b += result[1]
		
		a.record(move_a,move_b)
		b.record(move_b,move_a)
		
		log.append({
			"round": i+1,
			"A": move_a,
			"B": move_b,
			"scoreA": score_a,
			"scoreB": score_b
		})
	return{
		"scoreA": score_a,
		"scoreB": score_b,
		"log": log
	}
func _ready():
	s1 = Global.selected_s1
	s2 = Global.selected_s2


	match_result = run_match(s1, s2, 200)
	show_match_visuals()

func show_match_visuals():
	round_label.text = "%s: %d\n%s: %d" % [
		s1.nam, match_result["scoreA"],
		s2.nam, match_result["scoreB"]
	]

	end_button.pressed.connect(show_results)

func show_results():
	get_tree().change_scene_to_file("res://scenes/ResultsScene.tscn")
