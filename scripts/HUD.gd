extends Node2D

var gem_qnt = 5
var score = 0
var press = false
var normal = preload("res://sprites/objects/Pause.png")
var pressed = preload("res://sprites/objects/Pause_press.png")
var shop = preload("res://scenes/objects/object_avengerShop.tscn")
var hulkBuster = preload("res://scenes/objects/object_hulkBuster.tscn")
var sos = preload("res://sprites/objects/Sos.png")
var sos_pressed = preload("res://sprites/objects/Sos_press.png")
var sos_of = preload("res://sprites/objects/Sos_off.png")
var sos_of_pressed = preload("res://sprites/objects/Sos_of_press.png")
var hulkBusterAction = false


func _ready():
	$score.text = str(score)
	if admob.admob != null:
		admob.admob.showBanner()
	pass

func _on_object_enemySpawner_less_gem():
	if gem_qnt >= 0:
		get_node("gems/gem"+str(gem_qnt)).queue_free()
		gem_qnt -= 1
	else:
		game.player_score = score
		game.over = true
		if admob.admob != null:
			admob.admob.hideBanner()
		$anim.play("out")
	pass

func _on_object_enemySpawner_less_enemy(value):
	score += value
	$score.text = str(score)
	pass

func _on_pause_pressed():
	if !press:
		object_audioPlayer.play_song(6)
		get_tree().paused = !(get_tree().paused)
		if get_tree().paused:
			if admob.admob != null:
				admob.admob.showInterstitial()
			$buttons/pause.normal = pressed
		else:
			$buttons/pause.normal = normal
	pass

func _on_sos_released():
	if !get_tree().paused and !press and hulkBusterAction:
		object_audioPlayer.play_song(6)
		$buttons/sos.normal = sos_of
		$buttons/sos.pressed = sos_of_pressed
		var hb = hulkBuster.instance()
		hb.position = Vector2(210,200)
		add_child(hb)
		hulkBusterAction = false
		$hulkBuster.wait_time = 30
		$hulkBuster.start()
	pass

func _on_coins_released():
	if !press and  !get_tree().paused:
		object_audioPlayer.play_song(6)
		if admob.admob != null:
			admob.admob.showInterstitial()
		get_tree().paused = true
		var s = shop.instance()
		s.position = Vector2(210,360)
		add_child(s)
		press = true
	pass

func _on_hulkBuster_timeout():
	$buttons/sos.normal = sos
	$buttons/sos.pressed = sos_pressed
	hulkBusterAction = true
	pass

func change():
	scene.setScene("res://scenes/game/game_gameOver.tscn")
	pass