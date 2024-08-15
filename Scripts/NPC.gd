extends CharacterBody2D
signal complete
var can_talk = false

@export var player : CharacterBody2D

var saved_dialogue = []
var dialogue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if Inventory.trip_count >= 4 and not Inventory.heard_spider:
		%Prompt.text = "The Engineer has something to tell you"

func _process(_delta):
	if Input.is_action_just_pressed("select"):
		if can_talk:
			$Dialogue.visible = true
			player.toggle_walk(false)
			%Words.text = dialogue.pop_front()
	if $Dialogue.visible:
		if dialogue.size() > 0:
			%Next.visible = true
			%Close.visible = false
		else:
			%Next.visible = false
			%Close.visible = true

func set_dialogue(words):
	dialogue = words
	saved_dialogue = dialogue

func _on_talk_zone_body_entered(body):
	if dialogue.size() > 0:
		MusicPlayer.play_FX(MusicPlayer.menu_open)
		$Prompt.visible = true
		can_talk = true


func _on_talk_zone_body_exited(body):
	can_talk = false
	$Prompt.visible = false


func _on_next_pressed():
	MusicPlayer.play_FX(MusicPlayer.button_click)
	%Words.text = dialogue.pop_front()


func _on_close_pressed():
	MusicPlayer.play_FX(MusicPlayer.button_click)
	$Dialogue.visible = false
	player.toggle_walk(true)
	dialogue = saved_dialogue
	complete.emit()


func _on_dialogue_visibility_changed():
	if visible:
		MusicPlayer.play_FX(MusicPlayer.menu_open)
	else:
		MusicPlayer.play_FX(MusicPlayer.menu_close)
