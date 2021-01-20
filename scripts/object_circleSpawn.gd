extends Node2D

func _ready():
	for x in range(game.avenger_amount):
		if (game.avenger_lock[x] == 0 || game.avenger_lock[x] == 2):
			get_node('heads/h'+str(x)).modulate = "000000"
	pass

func _on_a0_pressed():
	if game.avenger_lock[0] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1
		get_parent().set_avenger(0)
		get_parent().pressed = false
		game.avenger_lock[0] = 2
		queue_free()
	pass

func _on_a1_pressed():
	if game.avenger_lock[1] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1
		get_parent().set_avenger(1)
		get_parent().pressed = false
		game.avenger_lock[1] = 2
		queue_free()
	pass

func _on_a2_pressed():
	if game.avenger_lock[2] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1
		get_parent().set_avenger(2)
		get_parent().pressed = false
		game.avenger_lock[2] = 2
		queue_free()
	pass

func _on_a3_pressed():
	if game.avenger_lock[3] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1	
		get_parent().set_avenger(3)
		get_parent().pressed = false
		game.avenger_lock[3] = 2
		queue_free()
	pass

func _on_a4_pressed():
	if game.avenger_lock[4] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1
		get_parent().set_avenger(4)
		get_parent().pressed = false
		game.avenger_lock[4] = 2
		queue_free()
	pass

func _on_a5_pressed():
	if game.avenger_lock[5] == 1:
		if get_parent().avenger != null:
			game.avenger_lock[get_parent().avenger.avenger] = 1
		get_parent().set_avenger(5)
		get_parent().pressed = false
		game.avenger_lock[5] = 2
		queue_free()
	pass