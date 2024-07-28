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


func _ready():
	update_everything()
	visible = false


func update_everything():
	update_results()
	update_using()


func clear_everything():
	
	for items in crafting_objects:
		crafting_objects[items] = 0
	
	for items in craft_results:
		craft_results[items] = 0
	
	update_everything()


func add_items(type, quantity):
	crafting_objects[type] += quantity


func add_results(type, quantity):
	craft_results[type] += quantity


func remove_items(type, quantity):
	crafting_objects[type] -= quantity

func remove_results(type, quantity):
	craft_results[type] -= quantity


func transfer(from, to, item, quant):
	
	var obj
	var from_inv
	
	match from:
		"objects":
			obj = true
		"results":
			obj = false
		"inventory":
			from_inv = true
	match to:
		"objects":
			obj = true
		"results":
			obj = false
		"inventory":
			from_inv = false
	
	if from_inv:
		Inventory.remove_items(item, quant)
		if obj:
			add_items(item, quant)
		elif not obj:
			add_results(item, quant)
	elif not from_inv:
		if obj:
			remove_items(item, quant)
		elif not obj:
			remove_results(item, quant)
		Inventory.add_items(item, quant)
	


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
	_on_cancel_pressed()
	visible = false
	closed.emit()


func _on_add_pc_pressed():
	if Inventory.check_quantity("Space Ore", 5):
		if Inventory.check_quantity("Space Crystal", 5):
			transfer("inventory", "objects", "Space Ore", 5)
			transfer("inventory", "objects", "Space Crystal", 5)
			add_results("Empty Cell", 1)
			update_everything()


func _on_add_rc_pressed():
	if Inventory.check_quantity("Space Wood", 10):
		if Inventory.check_quantity("Space Rock", 10):
			transfer("inventory", "objects", "Space Wood", 10)
			transfer("inventory", "objects", "Space Rock", 10)
			add_results("Repair Component", 1)
			update_everything()


func _on_craft_pressed():
	for items in craft_results:
		transfer("results", "inventory", items, craft_results[items])
	clear_everything()


func _on_cancel_pressed():
	for items in crafting_objects:
		transfer("objects", "inventory", items, crafting_objects[items])
	clear_everything()
