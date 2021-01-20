extends Node2D

var pos = []
var cont = 0
var limit = 0
var arrow = preload("res://scenes/objects/object_arrow.tscn")

func _ready():
	if len(game.enemy_pos) > 0:
		if game.enemy_amout < 7 || game.enemy_amout - game.last_enemy < 7:
			for i in range(game.enemy_amout):
				pos.append(i)
		else:
			for i in range(game.last_enemy, game.last_enemy+7):
				pos.append(i)
	else:
		get_parent().anim_back()
		queue_free()
	limit = len(pos)
	pass

func a_instance():
	if cont < limit:
		object_audioPlayer.play_song(2)
		var a = arrow.instance()
		a.position = Vector2(position.x, position.y)
		a.dir = pos[cont]
		cont += 1
		get_parent().add_child(a)
	else:
		get_parent().anim_back()
		queue_free()
	pass

func _on_timer_timeout():
	queue_free()
	pass

func _on_shot_timeout():
	a_instance()
	pass
