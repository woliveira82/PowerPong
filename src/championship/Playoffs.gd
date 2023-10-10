extends ColorRect

enum {BEGNNING, MIDDLE, END}

var _panel_position := BEGNNING
var _in_animation := false
var current_cup = null

@onready var _local_cup := $HBoxContainer/FinalMatch/LocalCup
@onready var _national_cup := $HBoxContainer/FinalMatch/NationalCup
@onready var _world_cup := $HBoxContainer/FinalMatch/WorldCup
@onready var _player := $AnimationPlayer


func _ready():
	current_cup = GameData.get_championship()
	_set_playoff_cup(current_cup.get_type())


func _set_playoff_cup(cup_type):
	_local_cup.visible = cup_type == "LOCAL"
	_national_cup.visible = cup_type == "NATIONAL"
	_world_cup.visible = cup_type == "WORLD"


func _input(event):
	if Input.is_action_just_pressed("player_right") and not _in_animation:
		if _panel_position == BEGNNING:
			_player.play("beginning_to_middle")
		elif _panel_position == MIDDLE:
			_player.play("middle_to_end")
		
	elif Input.is_action_just_pressed("player_left") and not _in_animation:
		if _panel_position == MIDDLE:
			_player.play("middle_to_beginning")
		elif _panel_position == END:
			_player.play("end_to_middle")


func animation_started():
	_in_animation = true


func animation_ended():
	_in_animation = false


func set_panel_to_beginning():
	_panel_position = BEGNNING


func set_panel_to_middle():
	_panel_position = MIDDLE


func set_panel_to_end():
	_panel_position = END
