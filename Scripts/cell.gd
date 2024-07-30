class_name Cell
extends Node

signal update

var energy = 0
var rads = 0

func _init():
	clear_all(cell_items)
	clear_all(ability_values)
	clear_all(ability_list)

func _ready():
	cell_text.make_read_only()
	cell_values.make_read_only()
	ability_types.make_read_only()
	update_cell()

func clear_all(object):
	for item in object:
		object[item] = 0
	

var cell_items = {
	"Empty Cell"      : 0,
	"Space Oil"       : 0,
	"Space Flower"    : 0,
	"Space Spiders"   : 0,
	"Alien Bone"      : 0,
	"Alien Brain"     : 0,
	"Alien Blood"     : 0,
	"Alien Dung"      : 0
}


var ability_values = {
	"Power"    : 0,
	"Sun"      : 0,
	"Poison"   : 0,
	"Strength" : 0,
	"Speed"    : 0,
	"Attack"   : 0,
	"Expload"  : 0
}

var ability_list = {
	"Increases power"                       : 0,
	"Slightly reduces radiation"            : 0,
	"Gives melee attacks poison damage"     : 0,
	"Increases health"                      : 0,
	"Raises speed"                          : 0,
	"Increases Damage"                      : 0,
	"Gives ranged attacks explosive damage" : 0
}

var cell_text = {
"Space Oil"       : "Increases power",
"Space Flower"    : "Slightly reduces radiation",
"Space Spiders"   : "Gives melee attacks poison damage",
"Alien Bone"      : "Increases health",
"Alien Brain"     : "Raises speed",
"Alien Blood"     : "Increases Damage",
"Alien Dung"      : "Gives ranged attacks explosive damage"
}

var cell_values = {
	"Space Oil"       : 25,
	"Space Flower"    : 10,
	"Space Spiders"   : 10,
	"Alien Bone"      : 25,
	"Alien Brain"     : 10,
	"Alien Blood"     : 1.2,
	"Alien Dung"      : .2
	}

var ability_types = {
	"Space Oil"       : "Power",
	"Space Flower"    : "Sun",
	"Space Spiders"   : "Poison",
	"Alien Bone"      : "Strength",
	"Alien Brain"     : "Speed",
	"Alien Blood"     : "Attack",
	"Alien Dung"      : "Expload"
	}

var display_text = []

func update_cell_text():
	display_text.clear()
	for ability in ability_list:
		if ability_list[ability] > 0 and ability != "Increases power":
			display_text.append(ability + " " + str(ability_list[ability]) + "x" + "\n\n")

func update_powers():
	for ability in ability_values:
		var object = ability_types.find_key(ability)
		ability_values[ability] = cell_items[object] * cell_values[object]

func update_abilities():
	for ability in ability_list:
		var object = cell_text.find_key(ability)
		ability_list[ability] = cell_items[object]

func update_cell():
	energy = 0
	rads = 0
	update_abilities()
	update_powers()
	update_cell_text()
	energy = cell_items["Space Oil"] * 25
	if energy >= 100:
		energy = 100
	var danger_count = cell_items["Space Spiders"] + cell_items["Alien Bone"] + cell_items["Alien Blood"] + cell_items["Alien Brain"] + cell_items["Alien Dung"]
	rads = danger_count * 20
	rads -= ability_values["Sun"]
	if rads >= 100:
		rads = 100
	update.emit()

func return_cell():
	for item in cell_items:
		Inventory.add_items(item, cell_items[item])
		remove_items(item, cell_items[item])

func get_item(item):
	return cell_items[item]

func add_items(type, quantity):
	cell_items[type] += quantity
	update_cell()

func remove_items(type, quantity):
	cell_items[type] -= quantity
	update_cell()

func check_quantity(type, quantity):
	return cell_items[type] >= quantity
