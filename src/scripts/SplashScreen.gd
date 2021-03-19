extends ColorRect


func _ready():
	$AnimationPlayer.play("fade_in_out")


func _to_main_menu():
	SceneDirector.change_to("res://src/scenes/control/MainMenu.tscn")
