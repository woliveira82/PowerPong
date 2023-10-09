extends ColorRect

var type_label = null

@onready var championship_label := $VBoxContainer/Type
@onready var regional_cup := $VBoxContainer/RegionalCup
@onready var nationa_cup := $VBoxContainer/NationalCup
@onready var world_cup := $VBoxContainer/WorldCup
@onready var player := $AnimationPlayer


func _ready():
	var championship_name = GameData.get_championship().get_type()
	championship_label.text = championship_name
	
	if championship_name == "NATIONAL":
		regional_cup.visible = false
		nationa_cup.visible = true
		world_cup.visible = false
		
	elif championship_name == "WORLD":
		regional_cup.visible = false
		nationa_cup.visible = false
		world_cup.visible = true

	player.play("3_s_exit")

func start_championship():
	SceneDirector.change_scene_to_playoffs()
