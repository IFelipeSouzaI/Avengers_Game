extends AudioStreamPlayer
var number = 0
var musics = [
"res://audios/SFX/Esmaga.ogg",
"res://audios/SFX/Explosoes.ogg",
"res://audios/SFX/Flechas.ogg",
"res://audios/SFX/Ricochete.ogg",
"res://audios/SFX/Tiro.ogg",
"res://audios/SFX/Trovao.ogg",
"res://audios/SFX/BtnGeralOpen.ogg",
"res://audios/SFX/BtnGeralClose.ogg",
"res://audios/SFX/Canhao.ogg"
]

func _ready():
	self.stream = load(musics[number])
	self.play()
	pass

func _on_sfxPlayer_finished():
	queue_free()
	pass
