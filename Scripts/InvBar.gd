extends HBoxContainer

var inv_bar = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory.updated.connect(update_bar)
	var list = get_children(false)
	for box in list:
		inv_bar.append(box)
	update_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_bar():
	var x = 0
	for items in Inventory.inv_disp:
		var pic = inv_bar[x].find_child("pic", true)
		var quant = inv_bar[x].find_child("quant")
		pic.texture = load(Inventory.inv_pics[items])
		quant.text = str(Inventory.inv_disp[items])
		if int(quant.text) >= 999:
			quant.text = "999"
		elif int(quant.text) <= 0:
			quant.text = "0"
		x += 1
	for y in inv_bar:
		var can_see : bool
		var quant = y.find_child("quant")
		var kids = y.get_children()
		if int(quant.text) <= 0:
			can_see = false
		else:
			can_see = true
		for z in kids:
			z.set_visible(can_see)
