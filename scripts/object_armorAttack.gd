extends Node2D

var action = 0
var origin
onready var armor = $sprite
var MOVE_SPEED = 0
var explo = preload("res://scenes/objects/anim_obj/explosion.tscn")
var damage = 3

func _ready():
	randomize()
	set_physics_process(true)
	origin = global_position
	pass

func _physics_process(delta):
	if action == 0:
		MOVE_SPEED += 10
		armor.rotation_degrees = 90
		move(Vector2(1,0), delta, MOVE_SPEED)
		if armor.global_position.y > 784:
			armor.scale = Vector2(2,2)
			armor.global_position.x = -64
			armor.global_position.y = 420
			action = 1
			$timer.start()
			get_parent().get_parent().get_parent().get_node("cam").shake(3,1)
	elif action == 1:
		armor.rotation_degrees = 0
		move(Vector2(1,0), delta, MOVE_SPEED/4)
		$explosions_area.global_position.x = armor.global_position.x-96
		if armor.global_position.x > 484:
			armor.scale = Vector2(1,1)
			armor.global_position.x = origin.x
			armor.global_position.y = 784
			action = 2
			$timer.stop()
	else:
		MOVE_SPEED -= 8
		armor.rotation_degrees = 270
		var motion = Vector2(1,0)
		move(motion, delta, MOVE_SPEED)
		if armor.global_position.distance_to(origin) < 32:
			game.avenger_anchor[1] = 2
		if armor.global_position.distance_to(origin) < 8:
			queue_free()
	pass

func move(dir, delta, vel):
	armor.move_local_x(dir.x*delta*vel)
	armor.move_local_y(dir.y*delta*vel)
	pass

func e_instance():
	var e = explo.instance()
	e.global_position = Vector2(armor.position.x-64, int(rand_range(96,600)))
	add_child(e)
	pass

func _on_timer_timeout():
	object_audioPlayer.play_song(1)
	e_instance()
	pass

func _on_explosions_area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(3+game.avenger_up[2])
	pass
