extends ColorRect

enum {BEGNNING, MIDDLE, END}

var _panel_position := BEGNNING
var _in_animation := false
var _championship_name := ""

@onready var _local_cup := $HBoxContainer/FinalMatch/LocalCup
@onready var _national_cup := $HBoxContainer/FinalMatch/NationalCup
@onready var _world_cup := $HBoxContainer/FinalMatch/WorldCup
@onready var _player := $AnimationPlayer
@onready var _quarter_finals := $HBoxContainer/QuarterFinals.get_child_count()
@onready var _semi_finals := $HBoxContainer/QuarterFinals
@onready var _final_match := $HBoxContainer/FinalMatch/MatchBackground1



func _ready():
	var championship_data = ChampionshipData.get_data()
	self._championship_name = championship_data["type"]
	
	self._set_quarter_finals(championship_data["quarter_finals"])
	if championship_data["semi_finals"]:
		self._set_semi_finals(championship_data["semi_finals"])
	
	if championship_data["final"]:
		self._set_final(championship_data["final"])
	
	self._set_playoff_cup(self._championship_name)


func _set_playoff_cup(cup_type):
	self._local_cup.visible = cup_type == ChampionshipData.LOCAL
	self._national_cup.visible = cup_type == ChampionshipData.NATIONAL
	self._world_cup.visible = cup_type == ChampionshipData.WORLD


func _input(event):
	if Input.is_action_just_pressed("player_right") and not _in_animation:
		if self._panel_position == BEGNNING:
			self._player.play("beginning_to_middle")
		elif self._panel_position == MIDDLE:
			self._player.play("middle_to_end")
		
	elif Input.is_action_just_pressed("player_left") and not _in_animation:
		if self._panel_position == MIDDLE:
			self._player.play("middle_to_beginning")
		elif self._panel_position == END:
			self._player.play("end_to_middle")


func animation_started():
	self._in_animation = true


func animation_ended():
	self._in_animation = false


func set_panel_to_beginning():
	self._panel_position = BEGNNING


func set_panel_to_middle():
	_panel_position = MIDDLE


func set_panel_to_end():
	_panel_position = END


func _set_quarter_finals(matches):
	for quarter_match in [1, 2, 3, 4]:
		self._quarter_finals.
		print(match_)


func _set_semi_finals(matches):
	pass


func _set_final(match_):
	pass
