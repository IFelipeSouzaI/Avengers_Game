extends Node2D

var enemies_life = 3
var enemies_speed = 0
var enemies_amout = 10
var enemies_wait = 1
var enemies_count = 0
var enemies_live = 0
var enemy = preload("res://scenes/objects/object_enemy.tscn")
var thanos = preload("res://scenes/objects/object_thanos.tscn")
var verify = false
var wave_num = 1
var wave_wait = 5
var thanos_life = 70
var thanos_time = false

signal less_gem
signal less_enemy(value)

func _ready():
	game.enemies = null
	game.enemies = []
	game.wave_time = false
	game.enemy_pos = null
	game.enemy_pos = []
	game.enemy_amout = 0
	game.last_enemy = 0
	randomize()
	$timer.wait_time = wave_wait
	$timer.start()
	set_process(true)
	pass

func _process(delta):
	if !game.wave_time and !game.over:
		if !($timing.visible):
			$wave/anim.play("anim")
			$timing.show()
			$wave.show()
		$timing.text = str(int($timer.time_left+1))
		$wave.text = "Wave "+str(wave_num)
	else:
		if $timing.visible:
			$timing.hide()
			$wave.hide()
	if verify:
		var finish = true
		if !thanos_time:
			for i in range(enemies_amout):
				if game.enemies[i] != null:
					finish = false
					break
		else:
			thanos_time = false
		if finish:
			if (wave_num%5) == 0:
				enemies_life += 1
				thanos_time = true
			if (wave_num%7) == 0:
				if enemies_speed < 200:
					enemies_speed += 25
			game.enemies = null
			game.enemies = []
			game.wave_time = false
			game.enemy_pos = null
			game.enemy_pos = []
			game.enemy_amout = 0
			game.last_enemy = 0
			enemies_amout += int(enemies_amout*0.20)
			enemies_count = 0
			$timer.wait_time = wave_wait
			$timer.start()
			verify = false
	pass

func e_instance():
	if !game.over:
		if thanos_time:
			var e = thanos.instance()
			e.position = Vector2(210,720)
			e.num = enemies_count
			e.life = thanos_life
			add_child(e)
			return e
		else:
			var e = enemy.instance()
			var pos = Vector2(int(rand_range(-64, 484)), 784)
			e.position = pos
			if pos.x < 0 || pos.x > 420:
				e.move_type = 0
			else:
				e.move_type = 1
			e.num = enemies_count
			e.life = enemies_life
			e.speed_correc = enemies_speed
			add_child(e)
			return e
	pass

func _on_timer_timeout():
	if enemies_count < enemies_amout:
		game.wave_time = true
		game.enemies.append(e_instance())
		enemies_count += 1
		game.enemy_amout += 1
		if thanos_time:
			wave_num += 1
			if wave_num > 3:
				if enemies_wait > 0.3:
					enemies_wait -= 0.05
			$timer.stop()
		else:
			$timer.wait_time = enemies_wait
			$timer.start()
	else:
		wave_num += 1
		if wave_num > 3:
			if enemies_wait > 0.3:
				enemies_wait -= 0.05
		verify = true
		$timer.stop()
	pass

func remove_enemy(num):
	if thanos_time:
		thanos_life += int((thanos_life*0.30))
		emit_signal('less_enemy', 50+int((thanos_life*0.30)))
		verify = true
	else:
		emit_signal('less_enemy', 7)
	game.last_enemy = num
	game.enemy_pos[num] = null
	game.enemies[num].queue_free()
	game.enemies[num] = null
	pass

