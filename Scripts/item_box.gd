extends TextureRect

@export var pic : String
@export var quant : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if pic != null:
		$HBoxContainer/pic.texture = load(pic)
	else:
		$HBoxContainer/pic.texture = load("res://Assets/UI/Icons/Battery item yellow.png")
	$quant.text = str(quant)

func set_image(image):
	$HBoxContainer/pic.texture = load(image)

func set_text(value : int):
	if value < 0:
		value = 0
	elif value >= 999:
		value = 999
	$quant.text = str(value)
