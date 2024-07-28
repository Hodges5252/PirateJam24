extends Node2D

signal updated

var inventory = {
	"Space Rock"      : 100,
	"Space Wood"      : 100,
	"Alien Parts"     : 0,
	"Repair Component": 0,
	"Empty Cell"      : 0,
	"Space Crystal"   : 100,
	"Space Ore"       : 100,
	"Space Oil"       : 0,
	"Space Flower"    : 0,
	"Space Spiders"   : 0,
	"Alien Bone"      : 0,
	"Alien Brain"     : 0,
	"Alien Blood"     : 0,
	"Alien Dung"      : 0
}

var placeholder = "res://Assets/UI/Icons/Poop.png"

var inv_pics = {
	"Space Rock"      : "res://Assets/UI/Icons/Rock collect.png",
	"Space Wood"      : "res://Assets/UI/Icons/Wood.png",
	"Alien Parts"     : "res://Assets/UI/Icons/Monster parts.png",
	"Repair Component": "res://Assets/UI/Icons/Floppy disk.png",
	"Empty Cell"      : "res://Assets/UI/Icons/Battery item red.png",
	"Space Crystal"   : "res://Assets/UI/Icons/Collect crystal purple.png",
	"Space Ore"       : "res://Assets/UI/Icons/Ore.png",
	"Space Oil"       : "res://Assets/UI/Icons/Oil can.png",
	"Space Flower"    : "res://Assets/UI/Icons/Sun flower.png",
	"Space Spiders"   : "res://Assets/UI/Icons/Ew gross item.png",
	"Alien Bone"      : "res://Assets/UI/Icons/Bone.png",
	"Alien Brain"     : "res://Assets/UI/Icons/Brain.png",
	"Alien Blood"     : "res://Assets/UI/Icons/Blood.png",
	"Alien Dung"      : "res://Assets/UI/Icons/Poop.png"
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

var cell_list = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in inventory:
		if inventory[item] < 0:
			inventory[item] = 0
	update_inv()

func update_inv():
	for item in inventory:
		if inventory[item] <= 0:
			inventory[item] = 0
	updated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func add_items(type, quantity):
	inventory[type] += quantity
	update_inv()

func remove_items(type, quantity):
	inventory[type] -= quantity
	update_inv()

func check_quantity(type, quantity):
	return inventory[type] >= quantity

class Cell:
	var energy = 0
	var rads = 0
	
	var cell_items = {
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
	
	var display_text = []
	
	func update_cell_text():
		display_text.clear()
		for ability in ability_list:
			if ability_list[ability] > 0:
				display_text.append(ability + " " + str(ability_list[ability]) + "x")
	
	func update_powers():
		for ability in ability_values:
			var object = Inventory.ability_types.find_key[ability]
			ability_values[ability] = cell_items[object] * Inventory.cell_values[object]
	
	func update_abilities():
		for ability in ability_list:
			var object = Inventory.cell_text.find_key[ability]
			ability_list[ability] = cell_items[object]
	
	func update_cell():
		energy = 0
		rads = 0
		update_abilities()
		update_powers()
		energy = cell_items["Space Oil"] * 25
		if energy >= 100:
			energy = 100
			display_text.append("Energy limit reached")
		var danger_count = cell_items["Space Spiders"] + cell_items["Alien Bone"] + cell_items["Alien Blood"] + cell_items["Alien Brain"] + cell_items["Alien Dung"]
		rads = danger_count * 20
		rads -= ability_values["Sun"]
		if rads >= 100:
			rads = 100
			display_text.append("Radiation levels extreme")
		
	
	func add_items(type, quantity):
		cell_items[type] += quantity
		update_cell()

	func remove_items(type, quantity):
		if cell_items[type] <= quantity:
			cell_items[type] -= quantity
			update_cell()

	func check_quantity(type, quantity):
		return cell_items[type] >= quantity
		
