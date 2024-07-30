extends Node2D

signal updated

var start_value = 100

var inventory = {
	"Space Rock"      : start_value,
	"Space Wood"      : start_value,
	"Alien Parts"     : start_value,
	"Repair Component": start_value,
	"Empty Cell"      : start_value,
	"Space Crystal"   : start_value,
	"Space Ore"       : start_value,
	"Space Oil"       : start_value,
	"Space Flower"    : start_value,
	"Space Spiders"   : start_value,
	"Alien Bone"      : start_value,
	"Alien Brain"     : start_value,
	"Alien Blood"     : start_value,
	"Alien Dung"      : start_value
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

var cell_list = []

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

func get_item(type):
	return inventory[type]



