extends Area2D

@onready var shoot_noise = preload("res://Assets/Sounds/SFX/laser sound.ogg")

var travelled_distance = 0
const SPEED = 500
const RANGE = 500

var can_explode = false
var explosion_damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.play_FX(shoot_noise)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(_body):
	queue_free()


func _on_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(25)
		if can_explode:
			var body_list = $Explosion.get_overlapping_areas()
			for bodies in body_list:
				if bodies.get_parent().has_method("take_damage"):
					bodies.get_parent().take_damage(25 * explosion_damage)
		queue_free()
