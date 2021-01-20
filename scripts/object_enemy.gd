extends KinematicBody2D

var velocity = Vector2(0,0)
var dir = Vector2(210,152)
var move_type = 1
var SPEED = 180
var speed_correc = 0
var num = 0
var life = 3
var thief = true
var coin = preload("res://scenes/objects/object_coinMore.tscn")

func _ready():
	$hpBar.max_value = life
	add_to_group("Enemy")
	randomize()
	set_physics_process(true)
	game.enemy_pos.append(global_position)
	SPEED = int(rand_range(80+speed_correc, 100+speed_correc))
	pass

func _physics_process(delta):
	if thief:
		if game.over:
			$anim.play("dead")
			thief = false
		$hpBar.value = life
		if life > 0:
			game.enemy_pos[num] = global_position
			if move_type == 0:
				if global_position.distance_to(dir) > 32:
					$sprite.look_at(dir)
					velocity = Vector2((dir.x-global_position.x),(dir.y-global_position.y)).normalized()
					velocity = move_and_slide(velocity*SPEED)
				else:
					get_parent().emit_signal("less_gem")
					$anim.play("dead")
					thief = false
			elif move_type == 1:
				if global_position.y > 392:
					velocity = Vector2(0,-1)
					$sprite.rotation_degrees = 270
					velocity = move_and_slide(velocity*SPEED)
				elif global_position.distance_to(dir) > 32:
					$sprite.rotation_degrees = 0
					$sprite.look_at(dir)
					velocity = Vector2((dir.x-global_position.x),(dir.y-global_position.y)).normalized()
					velocity = move_and_slide(velocity*SPEED)
				else:
					get_parent().emit_signal("less_gem")
					$anim.play("dead")
					thief = false
		else:
			die()
	pass

func damage(value):
	$sprite/damage.play("anim")
	life -= value
	pass

func die():
	if thief:
		var sort = int(rand_range(0,10.9))
		if sort > 7:
			var c = coin.instance()
			c.global_position = Vector2(global_position.x, global_position.y - 16)
			get_parent().add_child(c)
			game.coins += 1
	get_parent().remove_enemy(num)
	pass