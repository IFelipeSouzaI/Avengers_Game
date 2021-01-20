extends Node2D

var flag = true

func _ready():
	for i in range(game.avenger_amount):
		if game.avenger_lock[i] == 2:
			game.avenger_lock[i] = 1
	pass

func _on_start_pressed():
	if flag:
		object_audioPlayer.play_song(6)
		$anim.play('out')
		flag = false
	pass

func change():
	scene.setScene("res://scenes/game/game_main.tscn")
	pass