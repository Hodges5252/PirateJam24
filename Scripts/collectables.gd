extends StaticBody2D

@export var double : bool
@export var item = "Space Wood"
@export var quantity = 1
@export var health = 3
@export var color_change : bool

var body_count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if color_change:
		var color_check = randi_range(1,5)
		var color = ""
		match color_check:
			1:
				color = "purple"
			2:
				color = "blue"
			3:
				color = "green"
			4:
				color = "orange"
			5:
				color = "yellow"
		$Top.play(color)
		$Bottom.play(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if double:
		if body_count <= 0 and $OutlineBot.visible:
			body_count = 0
			$OutlineBot.set_visible(false)
			$OutlineTop.set_visible(false)
		elif body_count > 0:
			$OutlineBot.set_visible(true)
			$OutlineTop.set_visible(true)
	else:
		if body_count <= 0 and $Outline.visible:
			body_count = 0
			$Outline.set_visible(false)
		elif body_count > 0:
			$Outline.set_visible(true)
	


func _on_hilight_area_entered(_area):
	body_count += 1


func _on_hilight_area_exited(_area):
	body_count -= 1

func break_col():
	health -= 1
	if health <= 0:
		Inventory.add_items(item, quantity)
		queue_free()
