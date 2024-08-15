extends Node2D


func _ready():
	MusicPlayer._play_music(MusicPlayer.theme)

func _on_button_pressed():
	SceneManager.switch_scene("res://Scenes/intro_cutscene.tscn")
