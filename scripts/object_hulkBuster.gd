extends Node2D

var dest = [Vector2(-100,720), Vector2(55,720), Vector2(210,720), Vector2(365,720), Vector2(520,720)]
var bullet = preload("res://scenes/objects/object_busterBullet.tscn")

func shot():
	object_audioPlayer.play_song(8)
	for i in range(5):
		b_instance(dest[i])
	pass

func b_instance(dir):
	var b = bullet.instance()
	b.global_position = global_position
	b.dir = dir
	get_node("../").add_child(b)
	pass

func shake():
	get_parent().get_parent().get_node("cam").shake(2,10)
	pass