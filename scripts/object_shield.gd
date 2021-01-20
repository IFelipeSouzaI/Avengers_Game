extends Node2D

var HITS = 0
var LIMIT = 10
var MOVE_SPEED = 300
var origin = Vector2()
var correc = 0

func _ready():
	if game.enemy_amout < 5 and game.enemy_amout > 1:
		LIMIT = game.enemy_amout-1
	elif game.enemy_amout == 1:
		LIMIT = 1
	else:
		LIMIT = 10
	correc = game.last_enemy
	origin = global_position
	set_process(true)
	pass

func _process(delta):
	$sprite.rotate(MOVE_SPEED*delta)
	if HITS < LIMIT:
		if len(game.enemy_pos) > 0 and HITS+correc <= game.enemy_amout-1:
			if game.enemy_pos[HITS+correc] != null:
				var motion = Vector2(game.enemy_pos[HITS+correc].x - global_position.x, game.enemy_pos[HITS+correc].y - global_position.y).normalized()
				move(motion, delta, MOVE_SPEED)
				if global_position.distance_to(game.enemy_pos[HITS+correc]) < 16:
					object_audioPlayer.play_song(3)
					game.enemies[HITS+correc].damage(2+game.avenger_up[1])
					HITS += 1
					MOVE_SPEED += 30
			else:
				if HITS+correc < game.enemy_amout-1:
					correc += 1
		else:
			HITS = LIMIT
	else:
		HITS = LIMIT
		var motion = Vector2(origin.x - global_position.x, origin.y - global_position.y).normalized()
		move(motion, delta, MOVE_SPEED)
		if global_position.distance_to(origin) < 8:
			game.avenger_anchor[0] = 2
			queue_free()
	
	pass

func move(dir, delta, vel):
	move_local_x(dir.x*delta*vel)
	move_local_y(dir.y*delta*vel)
	pass