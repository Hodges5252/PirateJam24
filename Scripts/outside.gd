extends Node2D

@onready var SceneTransition = $Transition/Fade

func _ready():
	MusicPlayer._play_music(MusicPlayer.outside)
	SceneTransition.get_node("black").color.a = 255
	SceneTransition.play("fade_in")
	$Player.is_dead.connect(player_dead)

func player_dead():
	SceneManager.switch_scene("res://Scenes/death_transition.tscn")

func _on_area_2d_body_entered(_body):
	SceneTransition.play("fade_out")


func _on_sun_body_entered(body):
	if Inventory.mid_scene:
		SceneTransition.scene_to_change = "res://Scenes/mid_cutscene.tscn"
		Inventory.mid_scene = false
	else:
		SceneTransition.scene_to_change = "res://Scenes/sun.tscn"
	SceneTransition.play("fade_out")
