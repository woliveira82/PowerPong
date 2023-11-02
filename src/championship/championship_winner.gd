extends ColorRect

@onready var _player := $AnimationPlayer
var _locked := true


func _ready():
	self._player.play("show_winner")


func _process(delta):
	print(self._player.get_speed_scale())

func unlock_screen():
	self._locked = false


func _on_gui_input(event):
	if event as InputEventMouseButton:
		if self._locked:
			self._player.set_speed_scale(3.0)
		else:
			SceneDirector.change_scene_to_menu()
