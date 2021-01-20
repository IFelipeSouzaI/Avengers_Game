extends Node2D

var gem_qnt = 5

func _on_object_enemySpawner_less_gem():
	if gem_qnt >= 0:
		get_node("sprite/gem"+str(gem_qnt)).queue_free()
		gem_qnt -= 1
	else:
		queue_free()
	pass