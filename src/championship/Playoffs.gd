extends Control

enum {BEGNNING, MIDDLE, END}

var _panel_position := BEGNNING
var _in_animation := false
var _championship_name := ""

@onready var _local_cup := $Brackets/StageContainer/FinalMatch/LocalCup
@onready var _national_cup := $Brackets/StageContainer/FinalMatch/NationalCup
@onready var _world_cup := $Brackets/StageContainer/FinalMatch/WorldCup
@onready var _player := $AnimationPlayer
@onready var _quarter_finals := $Brackets/StageContainer/QuarterFinals.find_children(
	"MatchBackground?", "ColorRect", false
)
@onready var _semi_finals := $Brackets/StageContainer/SemiFinals.find_children(
	"MatchBackground?", "ColorRect", false
)
@onready var _final_match := $Brackets/StageContainer/FinalMatch/MatchBackground1


func _ready():
	var data = ChampionshipData.get_data()
	self._championship_name = data.type
	self._set_playoff_cup(self._championship_name)
	
	for index in range(4):
		self._quarter_finals[index].set_match(data.matches[index + 3])
	
	for index in range(2):
		self._semi_finals[index].set_match(data.matches[index + 1])
	
	self._final_match.set_match(data.matches[0])


func _set_playoff_cup(cup_type):
	self._local_cup.visible = cup_type == ChampionshipData.LOCAL
	self._national_cup.visible = cup_type == ChampionshipData.NATIONAL
	self._world_cup.visible = cup_type == ChampionshipData.WORLD


func _input(_event):
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


func _on_menu_button_pressed():
	SceneDirector.change_scene_to_menu()


func _on_play_button_pressed():
	MatchData.set_championship_opponent(ChampionshipData.get_next_opponent())
	SceneDirector.change_scene_to_match()
