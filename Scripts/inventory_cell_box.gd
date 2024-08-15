extends MarginContainer

var cell : Cell
signal new_select

func set_box(new_cell):
	cell = new_cell
	set_icon()
	#cell.display_junk()

func _process(_delta):
	if cell != null and cell != Inventory.selected_cell and cell != Inventory.equipped_cell:
		$PanelContainer/MarginContainer/HBoxContainer/Button.visible = true
	else:
		$PanelContainer/MarginContainer/HBoxContainer/Button.visible = false

func set_icon():
	if cell.cell_items["Empty Cell"] == 1 and cell.cell_items["Space Oil"] >= 1:
		if cell.get_item("Space Flower") >= 1:
			$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_image("res://Assets/UI/Icons/Battery item purple.png")
			print("purple")
		elif cell.get_item("Space Spiders") >= 1 or cell.get_item("Alien Bone") >= 1 or cell.get_item("Alien Brain") >= 1 or cell.get_item("Alien Blood") >= 1 or cell.get_item("Alien Dung") >= 1:
			$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_image("res://Assets/UI/Icons/Battery item orange.png")
			print("orange")
		else:
			$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_image("res://Assets/UI/Icons/Battery item yellow.png")
			print("yellow")
		$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_text(1)
	else:
		$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_image("res://Assets/UI/Icons/Battery item red.png")
		print("red")
		$PanelContainer/MarginContainer/HBoxContainer/CellThing.set_text(0)


func _on_button_pressed():
	MusicPlayer.play_FX(MusicPlayer.button_click)
	Inventory.selected_cell = cell
	new_select.emit()
