extends Node2D

var can_mine = false
var can_cell = false
var can_ref = false
var can_craft = false

@onready var SceneTransition = $CanvasLayer/Fade
# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransition.get_node("black").color.a = 255
	$CanvasLayer/Fade.play("fade_in")
	
	$CraM/Crafting/CraftingMenu.closed.connect(close_menu)
	$RefM/Refiner/RefinerMenu.closed.connect(close_menu)
	$DrillM/DrillArea/DrillMenu.closed.connect(close_menu)
	$CellM/CellConverter/CellMenu.closed.connect(close_menu)
	$BrokenMenu.closed.connect(close_repair)
	
	if ValManager.repair_progress["Drill"]:
		$DrillM/DrillArea/DrillMenu.set_oil(10)

func close_menu():
	$Player.toggle_walk(true)

func close_repair():
	if can_mine:
		if ValManager.repair_progress["Drill"]:
				$DrillM/DrillArea/DrillMenu.set_visible(true)
		else:
			$Player.toggle_walk(true)
	if can_cell:
		if ValManager.repair_progress["CellC"]:
				$CellM/CellConverter/CellMenu.set_visible(true)
		else:
			$Player.toggle_walk(true)
	if can_ref:
		if ValManager.repair_progress["Refin"]:
				$RefM/Refiner/RefinerMenu.set_visible(true)
		else:
			$Player.toggle_walk(true)

func _process(_delta):
	if Input.is_action_just_pressed("select"):
		if can_mine:
			if ValManager.repair_progress["Drill"]:
				$DrillM/DrillArea/DrillMenu.set_visible(true)
			else:
				$BrokenMenu.set_type("Drill")
				$BrokenMenu.set_cost(1)
				$BrokenMenu.set_visible(true)
			$Player.toggle_walk(false)
		if can_cell:
			if ValManager.repair_progress["CellC"]:
				$CellM/CellConverter/CellMenu.set_visible(true)
			else:
				$BrokenMenu.set_type("CellC")
				$BrokenMenu.set_cost(2)
				$BrokenMenu.set_visible(true)
			$Player.toggle_walk(false)
		if can_ref:
			if ValManager.repair_progress["Refin"]:
				$RefM/Refiner/RefinerMenu.set_visible(true)
			else:
				$BrokenMenu.set_type("Refin")
				$BrokenMenu.set_cost(5)
				$BrokenMenu.set_visible(true)
			$Player.toggle_walk(false)
		if can_craft:
			$CraM/Crafting/CraftingMenu.set_visible(true)
			$Player.toggle_walk(false)


func _on_drill_body_entered(_body):
	var outline = $DrillM.find_child("Outline", true)
	outline.set_visible(true)
	can_mine = true

func _on_drill_body_exited(_body):
	var outline = $DrillM.find_child("Outline", true)
	outline.visible = false
	can_mine = false


func _on_cell_converter_body_entered(_body):
	var outline = $CellM.find_child("Outline", true)
	outline.set_visible(true)
	can_cell = true

func _on_cell_converter_body_exited(_body):
	var outline = $CellM.find_child("Outline", true)
	outline.visible = false
	can_cell = false


func _on_refiner_body_entered(_body):
	var outline = $RefM.find_child("Outline", true)
	outline.set_visible(true)
	can_ref = true

func _on_refiner_body_exited(_body):
	var outline = $RefM.find_child("Outline", true)
	outline.set_visible(false)
	can_ref = false


func _on_crafting_body_entered(_body):
	var outline = $CraM.find_child("Outline", true)
	outline.set_visible(true)
	can_craft = true

func _on_crafting_body_exited(_body):
	var outline = $CraM.find_child("Outline", true)
	outline.set_visible(false)
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


func _on_area_2d_body_entered(_body):
	$CanvasLayer/Fade.play("fade_out")
