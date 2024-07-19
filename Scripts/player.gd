extends CharacterBody2D

@export var speed = 100
var can_move = true

func _ready():
	$AnimatedSprite2D.play("idle")

func get_input():
	if can_move:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		if Input.is_action_pressed("right"):
			if speed <= 100:
				$AnimatedSprite2D.play("walk")
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.play("run")
				$AnimatedSprite2D.flip_h = false
		elif Input.is_action_pressed("left"):
			if speed <= 100:
				$AnimatedSprite2D.play("walk")
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.play("run")
				$AnimatedSprite2D.flip_h = true
		elif Input.is_action_pressed("up"):
			if speed <= 100:
				$AnimatedSprite2D.play("walk")
			else:
				$AnimatedSprite2D.play("run")
		elif Input.is_action_pressed("down"):
			if speed <= 100:
				$AnimatedSprite2D.play("walk")
			else:
				$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
		velocity = input_direction * speed

func _process(delta):
	get_input()
	move_and_slide()

func toggle_walk(can_walk):
	can_move = can_walk


func _on_inv_close_pressed():
	$Inventory.set_visible(false)
	toggle_walk(true)

func _on_hud_inv_pressed():
	if $Settings.visible:
		$Settings.set_visible(false)
	if $Inventory.visible:
		$Inventory.set_visible(false)
		toggle_walk(true)
	else:
		$Inventory.set_visible(true)
		toggle_walk(false)



func _on_hud_set_pressed():
	if $Inventory.visible:
		$Inventory.set_visible(false)
	if $Settings.visible:
		$Settings.set_visible(false)
		toggle_walk(true)
	else:
		$Settings.set_visible(true)
		toggle_walk(false)


func _on_set_close_pressed():
	$Settings.set_visible(false)
	toggle_walk(true)
