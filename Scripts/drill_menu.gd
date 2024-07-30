extends CanvasLayer
signal closed

var oil_quant = 0

func set_oil(quant):
	oil_quant = quant
	update()

func update():
	%Oil.set_text(oil_quant)

func transfer_oil():
	Inventory.add_items("Space Oil", oil_quant)
	set_oil(0)

func _on_close_pressed():
	visible = false
	closed.emit()


func _on_get_oil_pressed():
	transfer_oil()
