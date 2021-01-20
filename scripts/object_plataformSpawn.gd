extends Node2D

var pressed = false
var seted = false

var avenger = null
var avenger_path = "res://scenes/objects/object_avenger.tscn"
var circle = preload("res://scenes/objects/object_circleSpawn.tscn")

signal damage(value)

func _ready():
	set_process_input(true)
	pass

func _input(event):
	
	if !game.wave_time:
		if !seted:
			if event is InputEventScreenTouch:
				if event.pressed:
					if global_position.distance_to(event.position) > 32 && pressed:
						get_node("object_circleSpawn").queue_free()
						pressed = false
					else:
						if global_position.distance_to(event.position) < 24 && !pressed:
							c_intance()
							pressed = true
		else:
			if event is InputEventScreenTouch:
				if event.pressed:
					if global_position.distance_to(event.position) < 24 && !pressed:
						c_intance()
						pressed = true
					else:
						if pressed:
							get_node("object_circleSpawn").queue_free()
							pressed = false
	else:
		if pressed:
			get_node("object_circleSpawn").queue_free()
			pressed = false
		if event is InputEventScreenTouch:
			if event.pressed:
				if global_position.distance_to(event.position) < 32:
					if avenger != null:
						if avenger.get_node("timer").time_left <= 0:
							avenger.attack_charged = true
	
	pass

func c_intance():
	var c = circle.instance()
	c.position = Vector2(0,0)
	add_child(c)
	pass

func set_avenger(num):
	if avenger == null:
		seted = true
		avenger = load(avenger_path).instance()
		avenger.avenger = num
		avenger.position = Vector2(0,-24)
		add_child(avenger)
	else:
		avenger.queue_free()
		avenger = null
		avenger = load(avenger_path).instance()
		avenger.avenger = num
		avenger.position = Vector2(0,-24)
		add_child(avenger)
	pass