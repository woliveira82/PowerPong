extends ColorRect

var type_label = null

@onready var championship_label := $VBoxContainer/Type
@onready var local_cup := $VBoxContainer/LocalCup
@onready var nationa_cup := $VBoxContainer/NationalCup
@onready var world_cup := $VBoxContainer/WorldCup
@onready var player := $AnimationPlayer


func _ready():
	var championship_name = ChampionshipData.get_type() 
	
	championship_label.text = championship_name
	local_cup.visible = championship_name == ChampionshipData.LOCAL
	nationa_cup.visible = championship_name == ChampionshipData.NATIONAL
	world_cup.visible = championship_name == ChampionshipData.WORLD

	player.play("3_s_exit")


func start_championship():
	SceneDirector.change_scene_to_playoffs()
