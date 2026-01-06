extends Node2D

@onready var s1_buttons = $Panel/S1/Panel.get_children()
@onready var s2_buttons = $Panel/S2/Panel.get_children()
@onready var s1_ready = $Panel/S1/ReadyS1
@onready var s2_ready = $Panel/S2/ReadyS2
@onready var dialogue_box = $DialogueBox
var dialogue = [
	{"text": "Welcome to StratSim! A simulation based on Prisoner's Dilemma, a famous problem in game theory"},
	{"text": "Please look at the Help Section and the Strategies Guide Section before you click Play!"}
]
var strategies := []
var s1_selected = -1
var s2_selected = -1
var s1_ready_state = false
var s2_ready_state = false
const SAVE_PATH = "user://save_data.save"



func _load_save():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.READ)
		var data = file.get_var()
		Global.tut_dialogue_seen = data.get("tut_dialogue_seen", false)
		Global.help_dialogue_seen = data.get("help_dialogue_seen",false)
		Global.strat_dialogue_seen = data.get("strat_dialogue_seen",false)
		file.close()

func _save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.WRITE)
	var data = {
		"tut_dialogue_seen": Global.tut_dialogue_seen,
		"help_dialogue_seen": Global.help_dialogue_seen,
		"strat_dialogue_seen": Global.strat_dialogue_seen,
	}
	file.store_var(data)
	file.close()
func _on_play_button_up() -> void:
	$Panel/AnimationPlayer.play("close")
	$Panel/Help.disabled = true
	$Panel/StratsInfo.disabled = true
	$Panel/Help.mouse_filter = $Panel/Help.MOUSE_FILTER_IGNORE
	$Panel/StratsInfo.mouse_filter = $Panel/StratsInfo.MOUSE_FILTER_IGNORE
func _on_help_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/help.tscn")
   
func _on_strats_info_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/stratsinfo1.tscn")
func _on_back_button_up() -> void:
	$Panel/AnimationPlayer.play("open")
	$Panel/Help.disabled = false
	$Panel/StratsInfo.disabled = false
func _ready():
	_load_save()
	if !Global.tut_dialogue_seen:
		dialogue_box.start_dialogue(dialogue)
		Global.tut_dialogue_seen = true
		_save()
	if Global.returning:
		$Panel/AnimationPlayer.play("close")
		$Panel/StratsInfo.disabled = true
		$Panel/Help.disabled = true
		Global.returning = false
	strategies = [
		preload("res://scripts/TitForTat.gd"),
		preload("res://scripts/AlwaysCooperate.gd"),
		preload("res://scripts/AlwaysDefect.gd"),
		preload("res://scripts/GrimTrigger.gd"),
		preload("res://scripts/Random.gd"),
		preload("res://scripts/Win-Stay-Lose-Shift.gd"),
		preload("res://scripts/Tester.gd"),
		preload("res://scripts/Joss.gd"),
		preload("res://scripts/Alternator.gd"),
		preload("res://scripts/ForgivingRandom.gd"),
		preload("res://scripts/Majority.gd")
	]

	
	for btn in s1_buttons:
		btn.toggle_mode = true
		btn.toggled.connect(on_s1_toggled.bind(btn))

	for btn in s2_buttons:
		btn.toggle_mode = true
		btn.toggled.connect(on_s2_toggled.bind(btn))

	
	s1_ready.disabled = true
	s2_ready.disabled = true
	s1_ready.pressed.connect(on_s1_ready)
	s2_ready.pressed.connect(on_s2_ready)

func on_s1_toggled(pressed: bool, button: Button):
	for b in s1_buttons:
		if b != button:
			b.set_block_signals(true)
			b.button_pressed = false
			b.set_block_signals(false)

	if pressed:
		s1_selected = s1_buttons.find(button)
	else:
		s1_selected = -1

	s1_ready.disabled = s1_selected == -1
func on_s2_toggled(pressed: bool, button: Button):
	for b in s2_buttons:
		if b != button:
			b.set_block_signals(true)
			b.button_pressed = false
			b.set_block_signals(false)

	if pressed:
		s2_selected = s2_buttons.find(button)
	else:
		s2_selected = -1

	s2_ready.disabled = s2_selected == -1

func on_s1_ready():
	s1_ready_state = true
	s1_ready.disabled = true
	check_both_ready()

func on_s2_ready():
	s2_ready_state = true
	s2_ready.disabled = true
	check_both_ready()

func check_both_ready():
	if s1_ready_state and s2_ready_state:
		start_match_scene()

func start_match_scene():
	var s1 = strategies[s1_selected].new()
	var s2 = strategies[s2_selected].new()
	Global.selected_s1 = s1
	Global.selected_s2 = s2
	get_tree().change_scene_to_file("res://scenes/MatchScene.tscn")
