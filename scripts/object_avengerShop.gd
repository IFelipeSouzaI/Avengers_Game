extends Node2D

var unlock_prices = [0, 30, 100, 80, 150, 50, 50]
var up_prices = [100, 15, 40, 50, 75, 25, 25]

func _ready():
	$coins.text = str(game.coins)
	$labels.get_node("price0").text = str(up_prices[0])
	get_node("buy_button0").price = up_prices[0]
	$levelBars.get_node("up"+str(0)).value = game.avenger_up[0]
	get_node("buy_button"+str(0)).update_things()
	for i in range(1,7):
		if game.avenger_lock[i-1] == 0:
			$avengers.get_node("a"+str(i)).modulate = "000000"
		$levelBars.get_node("up"+str(i)).value = game.avenger_up[i]
		get_node("buy_button"+str(i)).num = i
		if game.avenger_lock[i-1]:
			get_node("buy_button"+str(i)).price = up_prices[i]
			$labels.get_node("price"+str(i)).text = str(up_prices[i])
		else:
			get_node("buy_button"+str(i)).price = unlock_prices[i]
			$labels.get_node("price"+str(i)).text = str(unlock_prices[i])
		get_node("buy_button"+str(i)).update_things()
	pass


func update_things(num):
	$coins.text = str(game.coins)
	if num != 0:
		$avengers.get_node("a"+str(num)).modulate = "ffffff"
	$labels.get_node("price"+str(num)).text = str(up_prices[num])
	$levelBars.get_node("up"+str(num)).value = game.avenger_up[num]
	pass

func _on_close_released():
	object_audioPlayer.play_song(7)
	save_load.save_game('Avengers01')
	get_parent().press = false
	get_tree().paused = false
	queue_free()
	pass