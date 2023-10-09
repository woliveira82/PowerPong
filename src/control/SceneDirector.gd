extends Node

@onready var _player := $AnimationPlayer

var scene_name: String


func change_to(new_scene_name):
	scene_name = new_scene_name
	self._player.play("fade")


func _new_scene():
	get_tree().change_scene_to_file(scene_name)
