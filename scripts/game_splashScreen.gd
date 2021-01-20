extends Node2D

func _ready():
	save_load.load_game('Avengers01')
	if admob.admob != null:
		admob.admob.hideBanner()
	pass

func song_start():
	object_musicPlayer.play_song()
	pass

func change():
	if game.first_time:
		scene.setScene("res://scenes/game/game_register.tscn")
	else:
		scene.setScene("res://scenes/game/game_startScene.tscn")
	pass