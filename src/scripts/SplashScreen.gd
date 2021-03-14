extends ColorRect


func _ready():
	#yield($AnimationPlayer, "ready")
	$AnimationPlayer.play("fade_in_out")


func _to_main_menu():
	SceneDirector.change_to("res://src/scenes/GameField.tscn")
