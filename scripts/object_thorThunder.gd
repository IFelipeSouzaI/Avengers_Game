extends CanvasLayer

func _ready():
	get_parent().get_parent().get_parent().get_node("cam").shake(2,3)
	pass

func thunder():
	for i in range(game.last_enemy, game.enemy_amout):
		if game.enemies[i] != null:
			game.enemies[i].damage(1+game.avenger_up[4])
	pass

func noise():
	object_audioPlayer.play_song(5)
	pass