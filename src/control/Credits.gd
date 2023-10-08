extends ColorRect


func _ready():
	$AnimationPlayer.play("RollDown")


func back_to_menu():
	SceneDirector.change_to("res://src/control/MainMenu.tscn")
