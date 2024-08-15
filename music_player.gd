extends AudioStreamPlayer

const theme = preload("res://Assets/Music/Space Guy Main Theme.mp3")
const outside = preload("res://Assets/Music/space guy outside theme.mp3")
const cutscene = preload("res://Assets/Music/Space Guy Song 2 demo 2.mp3")
const base = preload("res://Assets/Music/SpaceGuyBaseSong.mp3")

const menu_open = preload("res://Assets/Sounds/SFX/menu open.ogg")
const menu_close = preload("res://Assets/Sounds/SFX/menu close.ogg")
const button_click = preload("res://Assets/Sounds/SFX/button click.ogg")


# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream):
	if stream == music:
		return
	stream = music
	play()

func play_FX(stream: AudioStream):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "fx_player"
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
