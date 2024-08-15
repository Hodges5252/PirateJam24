extends Node2D

@onready var SceneTransition = $Transition/Fade

func _ready():
	MusicPlayer._play_music(MusicPlayer.outside)
	SceneTransition.get_node("black").color.a = 255
	SceneTransition.play("fade_in")
	$Player.is_dead.connect(player_dead)
	if Inventory.equipped_cell.ability_values["Sun"] <= 0:
		Inventory.equipped_cell.force_rads = true

func player_dead():
	Inventory.equipped_cell.force_rads = false
	Inventory.equipped_cell.update_cell()
	SceneManager.switch_scene("res://Scenes/death_transition.tscn")
	

func _on_area_2d_body_entered(_body):
	SceneTransition.play("fade_out")

func _on_ship_body_entered(body):
	SceneTransition.scene_to_change = "res://Scenes/end_cutscene.tscn"
	SceneTransition.play("fade_out")
