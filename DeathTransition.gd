extends CanvasLayer

var dialogue = [
	"Your suit's security measures kick in, teleporting you back to the base safely for healing."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if Inventory.equipped_cell == null:
		dialogue.push_front("You tried to go outside without a Power Cell equipped...")
	else:
		dialogue.push_front("You hear your suit's warning system activate as your health becomes critical...")
	$DeathCutscene/Text.text = dialogue.pop_front()


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		if dialogue.size() > 0:
			$DeathCutscene/Text.text = dialogue.pop_front()
		else:
			SceneManager.switch_scene("res://Scenes/base.tscn")
