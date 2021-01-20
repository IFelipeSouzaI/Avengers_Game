extends TouchScreenButton

var price = 0
var num = 0

var unlock = false

var up = preload("res://sprites/objects/btnUp.png")
var upPressed = preload("res://sprites/objects/btnUp_press.png")

func _on_buy_button_pressed():
	if game.coins >= price:
		object_audioPlayer.play_song(6)
		if unlock:
			game.avenger_lock[num-1] = 1
			self.normal = up
			self.pressed = upPressed
			unlock = false
		else:
			if game.avenger_up[num] < 5:
				game.avenger_up[num] += 1
		game.coins -= price
		get_parent().update_things(num)
	pass

func update_things():
	if game.avenger_lock[num-1] == 0 and num != 0:
		unlock = true
	else:
		self.normal = up
		self.pressed = upPressed
	pass