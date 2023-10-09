extends CanvasLayer

var type_label = null
var regional_cup = null
var national_cup = null
var world_cup = null


func _ready():
	var championship_name = GameData.get_championship().get_type()
	$Type.text = championship_name
	
	if championship_name == "NATIONAL":
		$RegionalCup.visible = false
		$NationalCup.visible = true
		$WorldCup.visible = false
		
	elif championship_name == "WORLD":
		$RegionalCup.visible = false
		$NationalCup.visible = false
		$WorldCup.visible = true

	$AnimationPlayer.play("3_s_exit")

func start_championship():
	SceneDirector.change_scene_to_playoffs()
