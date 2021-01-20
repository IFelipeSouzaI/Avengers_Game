extends Node2D

var player_name = 'None'
var name_list = []
var flag = true
var returned = false

var v_button = preload("res://sprites/gui/btnGreen.png")
var v_buttonPressed = preload("res://sprites/gui/btnGreen_press.png")
var unv_button = preload("res://sprites/gui/btnRed.png")
var unv_buttonPressed = preload("res://sprites/gui/btnRed_press.png")

func _on_start_pressed():
	if returned:
		$anim.play("out")
		game.player_name = player_name
		returned = false
	pass

func _on_insert_text_text_changed(new_text):
	if flag:
		$insert_text.text = ''
		player_name = ''
		flag = false
	else:
		player_name = new_text
	pass

func _on_HTTP_get_request_completed(result, response_code, headers, body):
	if result != 3:
		var json = JSON.parse(body.get_string_from_utf8())
		var dict = json.result
		dict = dict["dreamlo"]
		dict = dict["leaderboard"]
		dict = dict["entry"]
		name_list = null
		name_list = []
		for i in range(len(dict)):
			var page = dict[i]
			name_list.append(page["name"])
		var valid = true
		for i in range(len(dict)):
			if player_name == name_list[i]:
				valid = false
				break
		if valid:
			$report.text = "Nome válido, clique em Confirmar para continuar!"
			$start.normal = v_button
			$start.pressed = v_buttonPressed
		else:
			$start.normal = unv_button
			$start.pressed = unv_buttonPressed
			$report.text = "O Nome já foi selecionado por outro player.\nTente algo diferente!"
		returned = valid
	else:
		$report.text = "Verifique sua conxão e tente novamente"
	pass

func _on_verify_pressed():
	if player_name != 'None' and player_name != '' and len(player_name) < 15:
		$HTTP_get.request("http://dreamlo.com/lb/5cb8af3b3eba5e041c18eddf/json")
	else:
		$report.text = "Insira um nome válido de até 14 caracteres..."
	pass

func change():
	game.first_time = false
	save_load.save_game('Avengers01')
	scene.setScene("res://scenes/game/game_startScene.tscn")
	pass