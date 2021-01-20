extends Node2D

var bullet = preload("res://scenes/objects/object_bullet.tscn")
var x = 9

func _on_end_timeout():
	game.avenger_anchor[5] = 2
	queue_free()
	pass

func _on_shot_timeout():
	b_instance()
	pass

func b_instance():
	var b = bullet.instance()
	b.position = Vector2(position.x + x, position.y)
	x*=-1
	get_parent().add_child(b)
	pass