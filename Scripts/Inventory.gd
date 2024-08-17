extends Node2D

signal updated

var cell_path = preload("res://Scripts/cell.gd")
var cell : Cell

var trip_count = -1

var start_value = 0

var mid_scene = true

var heard_first = false
var heard_second = false
var heard_spider = false

var first_dialogue = [
	"All the machines are broken!",
	"Monsters must have gotten in",
	"You will need to gather rock and wood to make repair materials",
	"In the base, go up to a machine and press 'e' to access the menu",
	"The Drill in the left corner is where you get oil for fuel",
	"The Cell Constructor above us is where you make Power Cells",
	"The machines to the left are the crafter and refiner",
	"The crafter is where you make empty cells and repair components",
	"The refiner is where you can convert monster parts into useful items",
	"You'll need to make repair components before anything else",
	"Your current power cell is pretty weak, so be careful!",
	"Outside, use the mouse to attack and gather resources",
	"Click 'e' to do a melee attack and mine items",
	"Click to shoot your blaster",
	"Be careful! Your blaster will drain your energy.",
	"Good luck! I wish I could help, but I'm too hurt."
]

var second_dialogue = [
	"You'll want to repair the drill first, then the Cell Constructor.",
	"The drill will pump oil when you are outside, you'll need it for the cells.",
]

var cell_dialogue = [
	"Here's how to use the Cell Constructor.",
	"First, you need at least one oil and one Empty Cell.",
	"After that, you can add other items, each one does something different.",
	"Those items also add radiation, which can hurt you over time.",
	"Once you've finished your cell, click the craft button to save it.",
	"Once that's done, you can equip it from your inventory.",
	"First, select the cell you want.",
	"If the selected cell has any powers, it will be shown in the box below it.",
	"Click add to add the cell, you'll know it works if the energy or radiation changes"
]

var spider_dialogue = [
	"A spider egg hatched while you were gone",
	"Can you take care of the webs for me?"
]

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
var equipped_cell : Cell
var selected_cell : Cell
# Called when the node enters the scene tree for the first time.
func _ready():
	cell = cell_path.new()
	cell.add_items("Empty Cell", 1)
	cell.add_items("Space Oil", 3)
	
	equipped_cell = cell
	cell_list.append(cell)
	
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



