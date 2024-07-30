extends CanvasLayer
signal closed
var cost = 5
var type = ""
var repair_count = 0

func _ready():
	update()

func set_type(menu):
	type = menu

func set_cost(amount):
	cost = amount
	update()

func update():
	%Required.text = "Components\nNeeded: " + str(cost - repair_count)
	%Icon.set_text(repair_count)
	if repair_count == cost:
		%Repair.visible = true

func _on_close_pressed():
	visible = false
	if repair_count > 0:
		Inventory.add_items("Repair Component", repair_count)
		repair_count = 0
	closed.emit()

func _on_add_items_pressed():
	if Inventory.check_quantity("Repair Component", 1) and repair_count < cost:
		Inventory.remove_items("Repair Component", 1)
		repair_count += 1
	update()

func _on_visibility_changed():
	%Repair.visible = false

func _on_repair_pressed():
	if repair_count == cost:
		repair_count = 0
		ValManager.repair_progress[type] = true
		_on_close_pressed()
