extends Node2D

var score_text = ""
var name_text = ""
var can_change = false

func _ready():
	$player_score.text = "Player:  " + str(game.player_name) + "     -     Score:  " + str(game.player_score)
	$HTTP_add.request("http://dreamlo.com/lb/2JMMzw41REy3gVqmnm8TnQUWCb_O8wxU-H2Qs9B_tleA/add/"+game.player_name+"/"+str(game.player_score)) 
	if admob.admob != null:
		admob.admob.showInterstitial()
	pass

func _on_HTTP_get_request_completed(result, response_code, headers, body):
	if result != 3:
		$conect_wait.hide()
		can_change = true
		var json = JSON.parse(body.get_string_from_utf8())
		var dict = json.result
		dict = dict["dreamlo"]
		dict = dict["leaderboard"]
		dict = dict["entry"]
		var size = len(dict)
		if size > 15:
			var pontVeri = dict[15]
			if game.player_score > int(pontVeri["score"]):
				$HTTP_remove.request("http://dreamlo.com/lb/2JMMzw41REy3gVqmnm8TnQUWCb_O8wxU-H2Qs9B_tleA/delete/"+pontVeri["name"])
			size = 15
		for i in range(size):
			var page = dict[i]
			name_text += page["name"] + "\n"
			score_text += str(page["score"]) + "\n"
		$name.text = name_text
		$score.text = score_text
		can_change = true
	else:
		print("Vc esta sem conxao, o jogo sera encerrado em 3, 2, 1")

func _on_change_pressed():
	if can_change:
		game.over = false
		game.wave_time = false
		save_load.save_game('Avengers01')
		scene.setScene("res://scenes/game/game_startScene.tscn")
	pass

func _on_HTTP_add_request_completed(result, response_code, headers, body):
	$HTTP_get.request("http://dreamlo.com/lb/5cb8af3b3eba5e041c18eddf/json")
	pass
