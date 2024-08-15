extends CharacterBody2D
signal is_dead

@export var base_speed = 100
@export var can_attack = true
@export var outside = false

@onready var swing = preload("res://Assets/Sounds/SFX/swing and a miss.ogg")

var speed = 100

var damage_rate = 5
var shoot_drain = 5

var speed_adjust = 0
var melee_adjust = 0
var drain_adjust = 0
var health_adjust = 0
var explode_adjust = 0
var radiation = 0
var can_explode = false


var can_move = true
var melee = false
var playing = false

var health = 100
var dead = false

func _ready():
	speed = base_speed
	play_whole("idle")
	toggle_walk(false)
	if outside:
		if Inventory.equipped_cell == null:
			health = 0
		else:
			speed_adjust = Inventory.equipped_cell.ability_values["Speed"]
			speed += speed_adjust
			melee_adjust = Inventory.equipped_cell.ability_values["Attack"]
			drain_adjust = Inventory.equipped_cell.ability_values["Shoot"]
			health_adjust = Inventory.equipped_cell.ability_values["Strength"]
			health += health_adjust
			radiation = Inventory.equipped_cell.rads
			if Inventory.equipped_cell.ability_values["Explode"] > 0:
				can_explode = true
				explode_adjust = Inventory.equipped_cell.ability_values["Explode"]
		$HUD.toggle_inv_button(false)
		$HUD.toggle_home_button(false)
	else:
		health = 100
		$HUD.set_max_health(health)
		$HUD.toggle_inv_button(true)
		$HUD.toggle_home_button(false)
	$HUD.update_values()

func toggle_inv(toggle):
	$HUD.toggle_inv(toggle)

func get_input():
	if can_move:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		if Input.is_action_pressed("right"):
			if speed <= 100:
				play_whole("walk")
				flip_sprites(false) 
			else:
				sync_play("run")
				flip_sprites(false) 
		elif Input.is_action_pressed("left"):
			if speed <= 100:
				play_whole("walk")
				flip_sprites(true) 
			else:
				sync_play("run")
				flip_sprites(true)
		elif Input.is_action_pressed("up"):
			if speed <= 100:
				play_whole("walk")
			else:
				sync_play("run")
		elif Input.is_action_pressed("down"):
			if speed <= 100:
				play_whole("walk")
			else:
				sync_play("run")
		else:
			play_whole("idle")
		velocity = input_direction * speed
	if can_attack:
		if Input.is_action_just_pressed("shoot"):
			if not playing:
				if melee:
					melee_attack()
				else:
					shoot()

func melee_attack():
	MusicPlayer.play_FX(swing)
	if velocity != Vector2(0,0):
		$top.play("melee")
		playing = true
	else:
		play_whole("melee")
		playing = true
		
	if $MeleeRange.has_overlapping_areas():
		var area_list = $MeleeRange.get_overlapping_areas()
		for areas in area_list:
			var parent = areas.get_parent()
			if parent.has_method("break_col"):
				parent.break_col()
			if parent.has_method("take_damage"):
				if melee_adjust > 0:
					parent.take_damage(34 * melee_adjust)
				else:
					parent.take_damage(34)


func shoot():
	if velocity != Vector2(0,0):
		$top.play("shoot")
		playing = true
	else:
		play_whole("shoot")
		playing = true
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = $ShootPoint.global_position
	new_bullet.global_rotation = $ShootPoint.global_rotation
	if can_explode:
		new_bullet.can_explode = true
		new_bullet.explosion_damage = explode_adjust
	var parent = get_parent()
	parent.add_child(new_bullet)
	Inventory.equipped_cell.lose_energy(shoot_drain - (shoot_drain * drain_adjust))


func _input(event):
	if event is InputEventMouseMotion:
		$mouse.global_position = get_global_mouse_position()

func _process(delta):
	if dead:
		is_dead.emit()
		print("ided")
	get_input()
	move_and_slide()
	$ShootPoint.look_at($mouse.global_position)
	if outside:
		if Inventory.equipped_cell != null:
			if Inventory.equipped_cell.current_energy <= 0:
				dead = true
		if health <= 0:
			dead = true
		var overlapping_mobs = $Damage.get_overlapping_areas()
		if overlapping_mobs.size() > 0:
			health -= damage_rate * overlapping_mobs.size() * delta
		if Inventory.equipped_cell.force_rads == true:
				radiation = 100

func break_spiders():
	if $MeleeRange.has_overlapping_areas():
		var area_list = $MeleeRange.get_overlapping_areas()
		for areas in area_list:
			var parent = areas.get_parent()
			if parent.has_method("break_col") and parent.visible:
				parent.break_col()

func toggle_walk(can_walk):
	if not can_walk:
		speed = 0
	else:
		speed = base_speed
		if Inventory.equipped_cell != null:
			speed_adjust = Inventory.equipped_cell.ability_values["Speed"]
			speed += speed_adjust
	can_move = can_walk

func sync_play(anim):
	if $whole.visible:
		$whole.set_visible(false)
	if not $top.visible:
		$top.set_visible(true)
		$bottom.set_visible(true)
	if not playing:
		$top.play(anim)
	$bottom.play(anim)

func play_whole(anim):
	if $top.visible:
		$top.set_visible(false)
		$bottom.set_visible(false)
	if not $whole.visible:
		$whole.set_visible(true)
	if not playing:
		$whole.play(anim)

func flip_sprites(setter):
	$whole.flip_h = setter
	$top.flip_h = setter
	$bottom.flip_h = setter

func _on_inv_close_pressed():
	$Inventory.set_visible(false)
	toggle_walk(true)

func _on_hud_inv_pressed():
	if $Settings.visible:
		$Settings.set_visible(false)
	if $Inventory.visible:
		$Inventory.set_visible(false)
		toggle_walk(true)
	else:
		$Inventory.set_visible(true)
		toggle_walk(false)



func _on_hud_set_pressed():
	if $Inventory.visible:
		$Inventory.set_visible(false)
	if $Settings.visible:
		$Settings.set_visible(false)
		toggle_walk(true)
	else:
		$Settings.set_visible(true)
		toggle_walk(false)


func _on_set_close_pressed():
	$Settings.set_visible(false)
	toggle_walk(true)



func _on_top_animation_finished():
	playing = false


func _on_whole_animation_finished():
	playing = false


func _on_melee_range_area_entered(area):
	if area.get_parent().has_method("get_input"):
		melee = true


func _on_melee_range_area_exited(area):
	if area.get_parent().has_method("get_input"):
		melee = false


func _on_timer_timeout():
	if radiation > 0:
		var value = randi_range(1, 100)
		print("Value: " + str(value) + " Radiation: " + str(radiation))
		if radiation >= value:
			print("Ouch!")
			health -= 5
