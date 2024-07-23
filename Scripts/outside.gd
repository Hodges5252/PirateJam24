extends Node2D

@onready var SceneTransition = $CanvasLayer/Fade

func _ready():
	SceneTransition.get_node("black").color.a = 255
	SceneTransition.play("fade_in")

func _on_area_2d_body_entered(_body):
	$CanvasLayer/Fade.play("fade_out")
