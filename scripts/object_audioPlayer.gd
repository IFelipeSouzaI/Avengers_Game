extends Node2D

var player = preload("res://scenes/objects/sfxPlayer.tscn")

func play_song(number):
	var m = player.instance()
	m.number = number
	add_child(m)
	pass