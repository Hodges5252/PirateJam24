extends CanvasLayer

var images = [
	"res://Assets/UI/Cutscenes/Home at last.png"
]

var monologue = [
	"The pilot made it!",
	"Switch",
	"As the pilot inserts the new power source into the ship, they are greeted by a familiar hum",
	"Finally,",
	"They will be able to escape this terrible place",
	"With the new power source, it is a simple matter of flying to the base and picking up the engineer",
	"Safe at last, they can return home.",
	"End"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer._play_music(MusicPlayer.theme)
	$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var variable = monologue.pop_front()
		if variable == "Switch":
			$IntroCutscene/TextureRect.texture = load(images.pop_front())
			$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()
		elif variable == "End":
			SceneManager.switch_scene("res://Scenes/credits.tscn")
		else:
			$IntroCutscene/MarginContainer/Label.text = variable

