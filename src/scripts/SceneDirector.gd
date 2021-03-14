extends Node

var scene_name: String


func change_to(new_scene_name):
	scene_name = new_scene_name
	$AnimationPlayer.play("fade")


func _new_scene():
	get_tree().change_scene(scene_name)
