extends Node2D

var MOVE_SPEED = 300
var dir = 0

func _process(delta):
	if len(game.enemy_pos) > dir:
		if game.enemy_pos[dir] != null:
			$sprite.look_at(game.enemy_pos[dir])
			var motion = Vector2(game.enemy_pos[dir].x - global_position.x, game.enemy_pos[dir].y - global_position.y).normalized()
			move(motion, delta, MOVE_SPEED)
			if global_position.distance_to(game.enemy_pos[dir]) < 8:
				game.enemies[dir].damage(3+game.avenger_up[5])
				queue_free()
		else:
			if len(game.enemy_pos) > dir+1:
				dir += 1
			else:
				queue_free()
	else:
		queue_free()
	pass

func move(dir, delta, vel):
	move_local_x(dir.x*delta*vel)
	move_local_y(dir.y*delta*vel)
	pass