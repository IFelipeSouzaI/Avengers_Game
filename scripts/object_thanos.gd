extends KinematicBody2D

var velocity = Vector2(0,0)
var dir = Vector2(210,152)
var move_type = 1
var SPEED = 180
var num = 0
var life = 70
var thief = true
var y = -10
var coin = preload("res://scenes/objects/object_coinMore.tscn")

func _ready():
	$hpBar.max_value = life
	add_to_group("Enemy")
	add_to_group("Boss")
	randomize()
	set_physics_process(true)
	game.enemy_pos.append(global_position)
	SPEED = 20
	pass

func _physics_process(delta):
	if thief:
		if game.over:
			$anim.play("dead")
			thief = false
		$hpBar.value = life
		if life > 0:
			game.enemy_pos[num] = global_position
			if global_position.distance_to(dir) > 32:
				velocity = Vector2(0,y)
				velocity = move_and_slide(velocity*SPEED)
				y = 0
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

func move():
	y = -10
	pass

func die():
	var sortP = 1
	for i in range(10):
		sortP *= -1
		var randP = (int(rand_range(10,30.9))*sortP)
		var c = coin.instance()
		c.global_position = Vector2(global_position.x + randP, global_position.y - 16 + randP)
		get_parent().add_child(c)
		game.coins += 1
	get_parent().remove_enemy(num)
	pass