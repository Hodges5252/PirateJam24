extends CharacterBody2D

@export var health = 100
@export var speed = 75
@export var bird = false
@export var item = "Alien Parts"
@export var quantity = 1
var body_count = 0

@export var roar_base : String
@export var hit_base : String
@export var die_base : String


@onready var roar = load(roar_base)
@onready var hit = load(hit_base)
@onready var die = load(die_base)

var target : Node2D
var alive = true
var dying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if bird:
		$top.visible = false
	sync_play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive:
		if target and not dying:
			sync_play("walk")
			var direction = global_position.direction_to(target.global_position)
			velocity = direction * speed
			move_and_slide()
			if direction.x < 0:
				flip_sprites(false)
			else:
				flip_sprites(true)
		elif not dying:
			velocity = Vector2.ZERO
			sync_play("idle")
	elif not dying:
		if body_count <= 0 and $top.visible:
			body_count = 0
			$top.set_visible(false)
		elif body_count > 0:
			$top.set_visible(true)

func take_damage(damage):
	if alive:
		if health > 0:
			MusicPlayer.play_FX(hit)
			health -= damage
		if health <= 0:
			MusicPlayer.play_FX(die)
			dying = true
			sync_play("death")
			speed = 0

func sync_play(play):
	if bird and alive:
		$bot.play(play)
	else:
		$top.play(play)
		$bot.play(play)

func flip_sprites(flip):
	$top.flip_h = flip
	$bot.flip_h = flip

func _on_range_body_entered(body):
	if body.has_method("get_input"):
		MusicPlayer.play_FX(roar)
		target = body


func _on_range_body_exited(body):
	if body == target:
		if body.has_method("get_input"):
			target = null


func _on_bot_animation_finished():
	$top.visible = false
	sync_play("dead")
	alive = false
	dying = false


func _on_object_area_entered(area):
	body_count += 1


func _on_object_area_exited(area):
	body_count -= 1

func break_col():
	if not alive:
		Inventory.add_items(item, quantity)
		queue_free()
