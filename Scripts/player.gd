extends CharacterBody2D

@export var speed = 100
@export var can_attack = true
var can_move = true
var melee = false
var playing = false


func _ready():
	play_whole("idle")

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
			if melee:
				melee_attack()
			else:
				shoot()

func melee_attack():
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
			var grandparent = parent.get_parent()
			if parent.has_method("break_col"):
				parent.break_col()


func shoot():
	if velocity != Vector2(0,0):
		$top.play("shoot")
		playing = true
	else:
		play_whole("shoot")
		playing = true


func _input(event):
	if event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		$mouse.global_position = get_global_mouse_position()
		#print("Box is at: ", $mouse.position)

func _process(delta):
	get_input()
	move_and_slide()

func toggle_walk(can_walk):
	can_move = can_walk

func sync_play(name):
	if $whole.visible:
		$whole.set_visible(false)
	if not $top.visible:
		$top.set_visible(true)
		$bottom.set_visible(true)
	if not playing:
		$top.play(name)
	$bottom.play(name)

func play_whole(name):
	if $top.visible:
		$top.set_visible(false)
		$bottom.set_visible(false)
	if not $whole.visible:
		$whole.set_visible(true)
	if not playing:
		$whole.play(name)

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
	melee = true


func _on_melee_range_area_exited(area):
	melee = false
