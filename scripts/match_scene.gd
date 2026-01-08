extends Control
class_name Match
@onready var round_label = $Panel/RoundLabel
@onready var end_button = $Panel/EndButton
@onready var skip_button = $Panel/SkipButton
@onready var score_s1_label = $Panel/ScoreS1Label
@onready var score_s2_label = $Panel/ScoreS2Label
@onready var moves_container = $Panel/ScrollContainer/MovesContainer
@onready var scroll_container = $Panel/ScrollContainer
@export var move_bubble_scene: PackedScene
@onready var bg = $AudioStreamPlayer
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
	fade_in()
	randomize()
	s1 = Global.selected_s1
	s2 = Global.selected_s2

	round_label.text = "%s VS %s" % [s1.nam, s2.nam]

	match_result = run_match(s1, s2, Global.rounds)

	update_scores(0, 0)

	skip_button.pressed.connect(skip_to_results)
	end_button.pressed.connect(go_back)
	
	play_next_round()


func run_match(a, b, rounds) -> Dictionary:
	if rounds == 0:
		rounds = 50
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
	if Global.speed == 0:
		Global.speed = 50
	await get_tree().create_timer(0.1/pow(Global.speed / 100.0, 0.5)).timeout
	play_next_round()

func add_move_bubble(a_move:String, b_move:String,skip = false):
	var bubble = move_bubble_scene.instantiate()
	moves_container.add_child(bubble)
	bubble.set_moves(a_move, b_move)
	if skip == false:
		await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	

func update_scores(a:int, b:int):
	score_s1_label.text = "%s: %d" % [s1.nam, a]
	score_s2_label.text = "%s: %d" % [s2.nam, b]


func skip_to_results():
	while current_round < match_result["log"].size():
		var data = match_result["log"][current_round]
		add_move_bubble(data["A"],data["B"],true)
		current_round += 1
	update_scores(match_result["scoreA"], match_result["scoreB"])

	end_button.visible = true


func go_back():
	Global.returning = true
	fade_out()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
func fade_in():
	bg.volume_db = -40
	bg.play()
	var tween = create_tween()
	tween.tween_property(
		bg,
		"volume_db",
		0.0,
		1.5
	)
func fade_out():
	var tween = create_tween()
	tween.tween_property(
		bg,
		"volume_db",
		-40.0,
		1.5
	)
	await tween.finished
	bg.stop()
