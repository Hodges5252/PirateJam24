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
func _process(_delta):
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
