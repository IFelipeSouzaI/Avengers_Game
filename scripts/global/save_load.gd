extends Node

var gameData = {
first_time = true,
player_name = "Fulano",
player_score = 30,
avenger_lock = [1,1,1,0,0,0],
avenger_up = [0,0,0,0,0,0,0],
coins = 3000
}

func save_game(var saveName):
	var fileSave = File.new()
	
	fileSave.open("user://"+saveName+".data", File.WRITE)
	
	var data = gameData
	
	data.first_time = game.first_time
	data.player_name = game.player_name
	data.player_score = game.player_score
	data.avenger_lock = game.avenger_lock
	data.avenger_up = game.avenger_up
	data.coins = game.coins
	
	fileSave.store_line(to_json(data))
	
	fileSave.close() 

func load_game(var saveName):
	
	var fileSave = File.new()
	
	if fileSave.file_exists("user://"+saveName+".data"):
		
		var data = {}
		
		fileSave.open("user://"+saveName+".data", File.READ)
		
		data = parse_json(fileSave.get_line())
		
		game.first_time = data["first_time"]
		game.player_name = data["player_name"]
		game.player_score = data["player_score"]
		game.avenger_lock = data["avenger_lock"]
		game.avenger_up = data["avenger_up"]
		game.coins = data["coins"]
	
	
	fileSave.close()