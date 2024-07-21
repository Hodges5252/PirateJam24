extends StaticBody2D

@export var item = "Space Wood"
@export var quantity = 1

var body_count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $OutlineBot:
		if body_count <= 0 and $OutlineBot.visible:
			body_count = 0
			$OutlineBot.set_visible(false)
			$OutlineTop.set_visible(false)
		elif body_count > 0:
			$OutlineBot.set_visible(true)
			$OutlineTop.set_visible(true)
	else:
		print("false")
	


func _on_hilight_area_entered(area):
	body_count += 1


func _on_hilight_area_exited(area):
	body_count -= 1

func break_col():
	Inventory.add_items(item, quantity)
	queue_free()
