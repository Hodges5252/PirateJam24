extends Node2D

var can_mine = false
var can_cell = false
var can_ref = false
var can_craft = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select"):
		if can_mine:
			$"Drill/Drill Menu".set_visible(true)
			$Player.toggle_walk(false)
		if can_cell:
			$CellConverter/CellMenu.set_visible(true)
			$Player.toggle_walk(false)
		if can_ref:
			$Refiner/RefineMenu.set_visible(true)
			$Player.toggle_walk(false)
		if can_craft:
			$Crafting/CraftingMenu.set_visible(true)
			$Player.toggle_walk(false)


func _on_drill_body_entered(body):
	$Drill/ColorRect.set_visible(true)
	can_mine = true

func _on_drill_body_exited(body):
	$Drill/ColorRect.visible = false
	can_mine = false


func _on_cell_converter_body_entered(body):
	$CellConverter/ColorRect.set_visible(true)
	can_cell = true

func _on_cell_converter_body_exited(body):
	$CellConverter/ColorRect.set_visible(false)
	can_cell = false


func _on_refiner_body_entered(body):
	$Refiner/ColorRect.set_visible(true)
	can_ref = true

func _on_refiner_body_exited(body):
	$Refiner/ColorRect.set_visible(false)
	can_ref = false


func _on_crafting_body_entered(body):
	$Crafting/ColorRect.set_visible(true)
	can_craft = true

func _on_crafting_body_exited(body):
	$Crafting/ColorRect.set_visible(false)
	can_craft = false


func _on_button_2_pressed():
	$"Drill/Drill Menu".set_visible(false)
	$Player.toggle_walk(true)


func _on_cell_close_pressed():
	$CellConverter/CellMenu.set_visible(false)
	$Player.toggle_walk(true)


func _on_refine_close_pressed():
	$Refiner/RefineMenu.set_visible(false)
	$Player.toggle_walk(true)


func _on_close_crafting_pressed():
	$Crafting/CraftingMenu.set_visible(false)
	$Player.toggle_walk(true)
