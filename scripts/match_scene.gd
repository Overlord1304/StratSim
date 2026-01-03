extends Control
class_name Match
@onready var round_label = $Panel/RoundLabel
@onready var end_button = $Panel/EndButton
@onready var skip_button = $Panel/SkipButton
@onready var score_s1_label = $Panel/ScoreS1Label
@onready var score_s2_label = $Panel/ScoreS2Label
@onready var moves_container = $Panel/ScrollContainer/MovesContainer
@export var move_bubble_scene: PackedScene
var s1
var s2
var match_result
var current_round := 0
var score_a := 0
var score_b := 0

const payoff = {
	"C,C": [3,3],
	"C,D": [0,5],
	"D,C": [5,0],
	"D,D": [1,1]
}

func _ready():
	s1 = Global.selected_s1
	s2 = Global.selected_s2

	round_label.text = "%s VS %s" % [s1.nam, s2.nam]

	match_result = run_match(s1, s2, 200)

	update_scores(0, 0)

	skip_button.pressed.connect(skip_to_results)
	end_button.pressed.connect(go_back)

	play_next_round()


func run_match(a, b, rounds) -> Dictionary:
	a.reset()
	b.reset()

	var scoreA = 0
	var scoreB = 0
	var log = []

	for i in range(rounds):
		var move_a = a.decide()
		var move_b = b.decide()

		var result = payoff["%s,%s" % [move_a, move_b]]
		scoreA += result[0]
		scoreB += result[1]

		a.record(move_a, move_b)
		b.record(move_b, move_a)

		log.append({
			"A": move_a,
			"B": move_b,
			"scoreA": scoreA,
			"scoreB": scoreB
		})

	return {
		"scoreA": scoreA,
		"scoreB": scoreB,
		"log": log
	}


func play_next_round():
	if current_round >= match_result["log"].size():
		end_button.visible = true
		return

	var data = match_result["log"][current_round]

	score_a = data["scoreA"]
	score_b = data["scoreB"]
	update_scores(score_a, score_b)

	add_move_bubble(data["A"], data["B"])

	current_round += 1

	await get_tree().create_timer(0.1).timeout
	play_next_round()

func add_move_bubble(a_move:String, b_move:String):
	var bubble = move_bubble_scene.instantiate()
	moves_container.add_child(bubble)
	bubble.set_moves(a_move, b_move)


func update_scores(a:int, b:int):
	score_s1_label.text = "%s: %d" % [s1.nam, a]
	score_s2_label.text = "%s: %d" % [s2.nam, b]


func skip_to_results():
	update_scores(match_result["scoreA"], match_result["scoreB"])
	end_button.visible = true
	current_round = match_result["log"].size()

func go_back():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
