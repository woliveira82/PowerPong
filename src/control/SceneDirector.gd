extends Node

@onready var _player := $AnimationPlayer

@export var playoff_tscn: PackedScene
@export var championship_splash_tscn: PackedScene
@export var credits_tscn: PackedScene
@export var menu_tscn: PackedScene
@export var match_tscn: PackedScene
@export var options_tscn: PackedScene

var _new_scene_name: PackedScene


func _change_to(new_scene_name):
	self._new_scene_name = new_scene_name
	self._player.play("fade")


func _new_scene():
	get_tree().change_scene_to_packed(self._new_scene_name)


func change_scene_to_playoffs():
	self._change_to(self.playoff_tscn)


func change_scene_to_championship_splash():
	self._change_to(self.championship_splash_tscn)


func change_scene_to_credits():
	self._change_to(self.credits_tscn)


func change_scene_to_menu():
	self._change_to(self.menu_tscn)


func change_scene_to_match():
	self._change_to(self.match_tscn)


func change_scene_to_options():
	self._change_to(self.options_tscn)
