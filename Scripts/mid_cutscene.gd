extends CanvasLayer

var images = [
	"res://Assets/UI/Cutscenes/The sun, it burns.png"
]

var monologue = [
	"Finally...",
	"After months of effort...",
	"The pilot finally makes it to the edge of the eclipse",
	"Switch",
	"The pilot, steps away from the light, takes a moment to brace themselves",
	"Would the new power source work?",
	"Would they finally be able to reach the ship?",
	"The pilot steps out into the light",
	"And hears the alarm of radiation overload",
	"The pilot's hopes fall through the floor",
	"Was all this effort for nothing?",
	"Maybe there are resources in the light that can help",
	"The pilot sets out, determined to reach the ship, eventually.",
	"End"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer._play_music(MusicPlayer.cutscene)
	$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var variable = monologue.pop_front()
		if variable == "Switch":
			$IntroCutscene/TextureRect.texture = load(images.pop_front())
			$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()
		elif variable == "End":
			SceneManager.switch_scene("res://Scenes/sun.tscn")
		else:
			$IntroCutscene/MarginContainer/Label.text = variable

