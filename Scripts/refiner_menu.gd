extends CanvasLayer
signal closed

var base_component = {
	"Alien Parts"  : 0
}

var result_parts = {
	"Alien Bone"  : 0,
	"Alien Brain"  : 0,
	"Alien Blood"   : 0,
	"Alien Dung"   : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_text():
	update_parts()
	update_results()

func gen_parts():
	for parts in result_parts:
		result_parts[parts] = base_component["Alien Parts"]

func save_parts():
	for results in result_parts:
		pass

func clear_everything():
	clear_results()
	clear_components()

func clear_results():
	for results in result_parts:
		result_parts[results] = 0

func clear_components():
	base_component["Alien Parts"] = 0

func add_component():
	base_component["Alien Parts"] = Inventory.inventory["Alien Parts"]
	Inventory.remove_items("Alien Parts", base_component["Alien Parts"])

func return_components():
	Inventory.add_items("Alien Parts", base_component["Alien Parts"])
	base_component["Alien Parts"] = 0

func save_results():
	for result in result_parts:
		Inventory.add_items(result, result_parts[result])
	clear_everything()

func update_parts():
	%Components.set_text(base_component["Alien Parts"])

func update_results():
	var children = %Results.get_children()
	var x = 0
	for results in result_parts:
		children[x].set_text(result_parts[results])
		x += 1

func _on_add_pressed():
	add_component()
	gen_parts()
	update_text()


func _on_convert_pressed():
	gen_parts()
	save_results()
	clear_everything()
	update_text()


func _on_cancel_pressed():
	return_components()
	clear_everything()
	update_text()


func _on_close_pressed():
	_on_cancel_pressed()
	visible = false
	closed.emit()
