extends Area2D

var travelled_distance = 0
const SPEED = 500
const RANGE = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()


func _on_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(25)
