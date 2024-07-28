extends CanvasLayer
signal closed


var crafting_objects = {
	"Space Wood"    : 0,
	"Space Rock"    : 0,
	"Space Crystal" : 0,
	"Space Ore"     : 0
}

var craft_results = {
	"Empty Cell"       : 0,
	"Repair Component" : 0
}


# Called when the node enters the scene tree for the first time.
func _ready():
	update_everything()
	visible = false

func update_everything():
	update_results()
	update_using()

func clear_everything():
	crafting_objects.clear()
	craft_results.clear()
	crafting_objects = {
	"Space Wood"    : 0,
	"Space Rock"    : 0,
	"Space Crystal" : 0,
	"Space Ore"     : 0
	}
	craft_results = {
	"Empty Cell"       : 0,
	"Repair Component" : 0
	}
	update_everything()

func add_items(type, quantity):
	crafting_objects[type] += quantity

func add_results(type, quantity):
	craft_results[type] += quantity

func remove_items(type, quantity):
	crafting_objects[type] -= quantity

func remove_results(type, quantity):
	craft_results[type] -= quantity


func update_results():
	var x = 0
	var grid_list = %ResultGrid.get_children()
	for items in craft_results:
		grid_list[x].set_image(Inventory.inv_pics[items])
		grid_list[x].set_text(craft_results[items])
		x += 1
	for y in grid_list:
		var can_see : bool
		var quant = y.find_child("quant")
		if int(quant.text) <= 0:
			can_see = false
		else:
			can_see = true
		y.set_visible(can_see)

func update_using():
	var x = 0
	var grid_list = %UsingGrid.get_children()
	for items in crafting_objects:
		grid_list[x].set_image(Inventory.inv_pics[items])
		grid_list[x].set_text(crafting_objects[items])
		x += 1
	for y in grid_list:
		var can_see : bool
		var quant = y.find_child("quant")
		if int(quant.text) <= 0:
			can_see = false
		else:
			can_see = true
		y.set_visible(can_see)

func _on_close_pressed():
	visible = false
	closed.emit()

func _on_add_pc_pressed():
	if Inventory.check_quantity("Space Ore", 5):
		if Inventory.check_quantity("Space Crystal", 5):
			add_items("Space Ore", 5)
			Inventory.remove_items("Space Ore", 5)
			add_items("Space Crystal", 5)
			Inventory.remove_items("Space Crystal", 5)
			add_results("Empty Cell", 1)
			print("Empty Cell Added!")
			update_everything()
		else:
			print("Not enough Crystal!")
	else:
		print("Not enough Ore!")

func _on_add_rc_pressed():
	if Inventory.check_quantity("Space Wood", 10):
		if Inventory.check_quantity("Space Rock", 10):
			add_items("Space Wood", 10)
			Inventory.remove_items("Space Wood", 10)
			add_items("Space Rock", 10)
			Inventory.remove_items("Space Rock", 10)
			add_results("Repair Component", 1)
			print("Repair Component Added!")
			update_everything()
		else:
			print("Not enough Rock!")
	else:
		print("Not enough Wood!")


func _on_craft_pressed():
	for items in craft_results:
		Inventory.add_items(items, craft_results[items])
		remove_results(items, craft_results[items])
	clear_everything()

func _on_cancel_pressed():
	for items in crafting_objects:
		Inventory.add_items(items, crafting_objects[items])
		remove_items(items, crafting_objects[items])
	clear_everything()
