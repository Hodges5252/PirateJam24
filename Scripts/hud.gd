extends CanvasLayer

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerInventory.closed.connect(inv_closed)
	$PlayerInventory.new_equipped.connect(new_cell)
	if Inventory.equipped_cell != null:
		Inventory.equipped_cell.current_energy = Inventory.equipped_cell.max_energy
	update_values()

func toggle_inv_button(toggle):
	%InventoryB.visible = toggle

func toggle_home_button(toggle):
	%GoHome.visible = toggle

func inv_closed():
	player.toggle_walk(true)

func new_cell():
	update_values()

func set_max_health(value_max):
	%Health.max_value = value_max


func update_values():
	if Inventory.equipped_cell != null:
		%Rads.value = Inventory.equipped_cell.rads
	if player.health > %Health.max_value:
		%Health.max_value = player.health

func _process(_delta):
	%Health.value = player.health
	if Inventory.equipped_cell != null:
		%Battery.value = Inventory.equipped_cell.current_energy
		if Inventory.equipped_cell.force_rads == true:
			%Rads.value = 100



func _on_button_pressed():
	$PlayerInventory.visible = true
	player.toggle_walk(false)


func _on_go_home_pressed():
	SceneManager.switch_scene("res://Scenes/death_transition.tscn")
