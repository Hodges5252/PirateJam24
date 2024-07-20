extends Node2D

var inventory = {
	"Space Rock"    : 0,
	"Space Wood"    : 0,
	"Alien Parts"   : 0,
	"Space Crystal" : 0,
	"Space Ore"     : 0,
	"Space Oil"     : 0,
	"Space Flower"  : 0,
	"Space Spiders" : 0,
	"Alien Bone"    : 0,
	"Alien Brain"   : 0,
	"Alien Blood"   : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_items(name, quantity):
	inventory[name] += quantity

func remove_items(name, quantity):
	if inventory[name] <= quantity:
		inventory[name] -= quantity

func check_quantity(name, quantity):
	return inventory[name] <= quantity
