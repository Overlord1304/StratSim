extends Control

@onready var s1_buttons = $Panel/HBoxContainer1.get_children()
@onready var s2_buttons = $Panel/HBoxContainer2.get_children()
@onready var s1_ready = $Panel/S1Ready
@onready var s2_ready = $Panel/S2Ready

var strategies := []
var s1_selected = -1
var s2_selected = -1
var s1_ready_state = false
var s2_ready_state = false

func _ready():
	
	strategies = [
		preload("res://scripts/AlwaysCooperate.gd").new(),
		preload("res://scripts/AlwaysDefect.gd").new(),
		preload("res://scripts/TitForTat.gd").new(),
		preload("res://scripts/GrimTrigger.gd").new()
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

func on_s1_toggled(pressed,button):
	for b in s1_buttons:
		if b != button:
			b.pressed = false
			b.block_signals = true
			b.button_pressed = false
			b.block_signals = false
	if pressed:
		s1_selected = s1_buttons.find(button)
	else:
		s1_selected = -1
	s1_ready.disabled = s1_selected == -1

func on_s2_toggled(pressed,button):
	for b in s2_buttons:
		if b != button:
			b.block_signals = true
			b.button_pressed = false
			b.block_signals = false
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
	var s1 = strategies[s1_selected]
	var s2 = strategies[s2_selected]
	Global.selected_s1 = s1
	Global.selected_s2 = s2
	get_tree().change_scene_to_file("res://scenes/MatchScene.tscn")
