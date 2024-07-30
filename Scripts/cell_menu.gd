extends CanvasLayer
signal closed

var cell_path = preload("res://Scripts/cell.gd")
var cell : Cell
@onready var flower_icon = %FlowerIcon
@onready var spider_icon = %SpiderIcon
@onready var bone_icon = %BoneIcon
@onready var brain_icon = %BrainIcon
@onready var blood_icon = %BloodIcon
@onready var dung_icon = %DungIcon

@onready var display = {
	flower_icon : %FlowerBox,
	spider_icon : %SpiderBox,
	bone_icon : %BoneBox,
	brain_icon : %BrainBox,
	blood_icon : %BloodBox,
	dung_icon : %DungBox
}

# Called when the node enters the scene tree for the first time.
func _ready():
	new_cell()
	update_everything()

func update_everything():
	%EmptyCell.set_text(cell.cell_items["Empty Cell"])
	%OilIcon.set_text(cell.cell_items["Space Oil"])
	update_bars()
	update_list()
	update_component_list()
	update_icons()
	check_validity()

func update_icons():
	for icon in display:
		icon.set_text(int(cell.cell_items[icon.item_type]))

func update_list():
	var ability_text = %AbilityList
	ability_text.text = ""
	for line in cell.display_text:
		ability_text.text += line

func update_component_list():
	for object in display:
		if Inventory.get_item(object.item_type) > 0 or cell.cell_items[object.item_type] > 0:
			display[object].visible = true
		else:
			display[object].visible = false

func check_validity():
	if cell.cell_items["Empty Cell"] == 1 and cell.cell_items["Space Oil"] >= 1:
		if cell.get_item("Space Flower") >= 1:
			%CellIcon.set_image("res://Assets/UI/Icons/Battery item purple.png")
		elif cell.get_item("Space Spiders") >= 1 or cell.get_item("Alien Bone") >= 1 or cell.get_item("Alien Brain") >= 1 or cell.get_item("Alien Blood") >= 1 or cell.get_item("Alien Dung") >= 1:
			%CellIcon.set_image("res://Assets/UI/Icons/Battery item orange.png")
		else:
			%CellIcon.set_image("res://Assets/UI/Icons/Battery item yellow.png")
		%CellIcon.set_text(1)
		return true
	else:
		%CellIcon.set_image("res://Assets/UI/Icons/Battery item red.png")
		%CellIcon.set_text(0)
		return false

func new_cell():
	cell = cell_path.new()
	cell.update.connect(update_everything)
	update_everything()

func update_bars():
	%PowerBar.value = cell.energy
	%RadBar.value = cell.rads

func add_items(item):
	if item == "Empty Cell":
		if Inventory.check_quantity(item, 1) and cell.get_item(item) == 0:
			Inventory.remove_items(item, 1)
			cell.add_items(item, 1)
	elif Inventory.check_quantity(item, 1):
		Inventory.remove_items(item, 1)
		cell.add_items(item, 1)

func remove_items(item):
	if cell.check_quantity(item, 1):
		cell.remove_items(item, 1)
		Inventory.add_items(item, 1)

func _on_visibility_changed():
	if visible:
		new_cell()

func _on_add_cell_pressed():
	add_items("Empty Cell")

func _on_remove_cell_pressed():
	remove_items("Empty Cell")

func _on_add_oil_pressed():
	add_items("Space Oil")

func _on_remove_oil_pressed():
	remove_items("Space Oil")

func _on_close_pressed():
	_on_clear_cell_pressed()
	visible = false
	closed.emit()

func _on_craft_cell_pressed():
	if check_validity():
		Inventory.cell_list.append(cell)
		new_cell()

func _on_clear_cell_pressed():
	cell.return_cell()

func _on_add_flower_pressed():
	add_items("Space Flower")

func _on_remove_flower_pressed():
	remove_items("Space Flower")

func _on_add_spider_pressed():
	add_items("Space Spiders")

func _on_remove_spider_pressed():
	remove_items("Space Spiders")

func _on_add_bone_pressed():
	add_items("Alien Bone")

func _on_remove_bone_pressed():
	remove_items("Alien Bone")

func _on_add_brain_pressed():
	add_items("Alien Brain")

func _on_remove_brain_pressed():
	remove_items("Alien Brain")

func _on_add_blood_pressed():
	add_items("Alien Blood")

func _on_remove_blood_pressed():
	remove_items("Alien Blood")

func _on_add_dung_pressed():
	add_items("Alien Dung")

func _on_remove_dung_pressed():
	remove_items("Alien Dung")

