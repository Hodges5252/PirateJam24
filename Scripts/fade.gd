extends Control

var switch_scene = "fade_out"
@export var scene_to_change : String
@export var player : CharacterBody2D

func _ready():
	$black.color.a = 255
	$black.visible = true

func play(anim):
	player.toggle_walk(false)
	$black.visible = true
	$AnimationPlayer.play(anim)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		SceneManager.switch_scene(scene_to_change)
	else:
		player.toggle_walk(true)
