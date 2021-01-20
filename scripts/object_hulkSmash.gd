extends Node2D

var cont = 0

func _ready():
	object_audioPlayer.play_song(0)
	get_parent().get_parent().get_parent().get_node("cam").shake(2,2)
	smash()
	pass

func smash():
	for i in range(game.last_enemy, game.enemy_amout):
		if game.enemies[i] != null:
			game.enemies[i].damage(2+game.avenger_up[3])
	pass

func _on_timer_timeout():
	smash()
	cont += 1
	if cont == 2:
		queue_free()
	pass
