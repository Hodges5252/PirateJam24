extends CanvasLayer

var images = [
	"res://Assets/UI/Cutscenes/the landing.png",
	"res://Assets/UI/Cutscenes/a new beginning.png",
	"res://Assets/UI/Cutscenes/Base.png",
	"res://Assets/UI/Cutscenes/He comes.png",
	"res://Assets/UI/Cutscenes/He kills.png",
	"res://Assets/UI/Cutscenes/a new beginning.png"
]

var monologue = [
	"The year is 2053.",
	"The small crew of the Starship Citrinitas ventures into unknown space.",
	"They discover...",
	"Switch",
	"A Nightmare.",
	"The radiation from the nearest star overloaded the ship's energy cells",
	"Resulting an emergency landing on the nearest planet",
	"Switch",
	"A planet with the moon and sun tidally locked with it's sun",
	"The permanent eclipse offered a shadowy sanctuary from the dangers of the alien light",
	"Switch",
	"Setting up a temporary base, the crew's scientist committed to find a new energy source...",
	"A source cobbled together from the elements found on the planet.",
	"Switch",
	"The search for elements proved dangerous, as the planet was inhabited by terrifying creatures",
	"Switch",
	"The crew's scientist did not survive.",
	"Switch",
	"With the scientist dead, the engineer injured, it is now up to the pilot to find a way off the planet.",
	"End"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var variable = monologue.pop_front()
		if variable == "Switch":
			$IntroCutscene/TextureRect.texture = load(images.pop_front())
			$IntroCutscene/MarginContainer/Label.text = monologue.pop_front()
		elif variable == "End":
			SceneManager.switch_scene("res://Scenes/base.tscn")
		else:
			$IntroCutscene/MarginContainer/Label.text = variable
