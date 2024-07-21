extends Node2D

signal updated

var inventory = {
	"Space Rock"      : 0,
	"Space Wood"      : 0,
	"Alien Parts"     : 0,
	"Repair Component": 0,
	"Empty Cell"      : 0,
	"Space Crystal"   : 0,
	"Space Ore"       : 0,
	"Space Oil"       : 0,
	"Space Flower"    : 0,
	"Space Spiders"   : 0,
	"Alien Bone"      : 0,
	"Alien Brain"     : 0,
	"Alien Blood"     : 0
}

var inv_pics = {
	"Space Rock"      : Image.load_from_file("res://Assets/UI/Icons/Rock collect.png"),
	"Space Wood"      : Image.load_from_file("res://Assets/UI/Icons/Wood.png"),
	"Alien Parts"     : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Repair Component": Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Empty Cell"      : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Space Crystal"   : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Space Ore"       : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Space Oil"       : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Space Flower"    : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Space Spiders"   : Image.load_from_file("res://Assets/UI/Icons/Poop.png"),
	"Alien Bone"      : Image.load_from_file("res://Assets/UI/Icons/Bone.png"),
	"Alien Brain"     : Image.load_from_file("res://Assets/UI/Icons/Brain.png"),
	"Alien Blood"     : Image.load_from_file("res://Assets/UI/Icons/Blood.png"),
	"Alien Dung"      : Image.load_from_file("res://Assets/UI/Icons/Poop.png")
}

var inv_disp = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in inventory:
		if inventory[item] < 0:
			inventory[item] = 0
	update_inv()

func update_inv():
	inv_disp.clear()
	for item in inventory:
		if inventory[item] > 0:
			inv_disp[item] = inventory[item]
	updated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_items(type, quantity):
	inventory[type] += quantity
	update_inv()

func remove_items(type, quantity):
	if inventory[type] <= quantity:
		inventory[type] -= quantity
		update_inv()

func check_quantity(type, quantity):
	return inventory[type] <= quantity
