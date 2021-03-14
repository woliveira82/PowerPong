extends Node


const main_menu = preload("res://src/scenes/GameField.tscn")


func to_main_menu():
	self.get_child(0).queue_free()
	self.add_child(main_menu.instance())
	get_tree().change_scene("res://src/scenes/GameField.tscn")
