extends CanvasLayer
signal closed
signal new_equipped

var cell_list_item = preload("res://Scenes/inventory_cell_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	update_list()

func update_list():
	for item in Inventory.cell_list:
		var new_cell = cell_list_item.instantiate()
		new_cell.set_box(item)
		new_cell.set_icon()
		new_cell.new_select.connect(new_selected)
		%CellList.add_child(new_cell)

func clear_list():
	var cell_list = %CellList.get_children()
	for child in cell_list:
		child.queue_free()

func _process(_delta):
	if Inventory.selected_cell == null:
		%AddCell.visible = false
	else:
		%AddCell.visible = true
	if Inventory.equipped_cell == null:
		%RemoveButton.visible = false
	else:
		%RemoveButton.visible = true

func new_selected():
	print("updated!!")
	#Inventory.selected_cell.display_junk()
	update_everything()

func update_equipped_icon():
	if Inventory.equipped_cell != null:
		if Inventory.equipped_cell.cell_items["Empty Cell"] == 1 and Inventory.equipped_cell.cell_items["Space Oil"] >= 1:
			if Inventory.equipped_cell.get_item("Space Flower") >= 1:
				%CellIcon.set_image("res://Assets/UI/Icons/Battery item purple.png")
				
			elif Inventory.equipped_cell.get_item("Space Spiders") >= 1 or Inventory.equipped_cell.get_item("Alien Bone") >= 1 or Inventory.equipped_cell.get_item("Alien Brain") >= 1 or Inventory.equipped_cell.get_item("Alien Blood") >= 1 or Inventory.equipped_cell.get_item("Alien Dung") >= 1:
				%CellIcon.set_image("res://Assets/UI/Icons/Battery item orange.png")
				
			else:
				%CellIcon.set_image("res://Assets/UI/Icons/Battery item yellow.png")
				
			%CellIcon.set_text(1)
		else:
			%CellIcon.set_image("res://Assets/UI/Icons/Battery item red.png")
			
			%CellIcon.set_text(0)

func update_everything():
	update_selected_text()
	update_equipped_icon()
	update_equipped_text()

func update_equipped_text():
	if Inventory.equipped_cell != null:
		var ability_text = %EquippedText
		ability_text.text = ""
		for line in Inventory.equipped_cell.display_text:
			ability_text.text += line
		%EnVal.text = str(Inventory.equipped_cell.max_energy)
		%RadVal.text = str(Inventory.equipped_cell.rads)

func update_selected_text():
	if Inventory.selected_cell != null:
		var ability_text = %description
		ability_text.text = ""
		for line in Inventory.selected_cell.display_text:
			ability_text.text += line

func _on_close_pressed():
	visible = false
	closed.emit()


func _on_visibility_changed():
	if visible:
		MusicPlayer.play_FX(MusicPlayer.menu_open)
	else:
		MusicPlayer.play_FX(MusicPlayer.menu_close)
	Inventory.selected_cell = null
	clear_list()
	update_list()


func _on_add_cell_pressed():
	Inventory.equipped_cell = Inventory.selected_cell
	Inventory.selected_cell = null
	new_equipped.emit()
	update_everything()


func _on_remove_button_pressed():
	if Inventory.equipped_cell != null:
		Inventory.equipped_cell = null
		update_everything()
