extends Area2D

var speed = 400
var dir = Vector2(420,720)
var motion = Vector2()

func _ready():
	set_process(true)
	motion = Vector2(dir.x - global_position.x, dir.y - global_position.y).normalized()
	pass

func _process(delta):
	$sprite.look_at(dir)
	move(motion, delta, speed)
	if global_position.y > 720 || global_position.x > 420 || global_position.x < 0:
		queue_free()
	pass

func move(way, delta, vel):
	move_local_x(way.x*delta*vel)
	move_local_y(way.y*delta*vel)
	pass

func _on_object_busterBullet_body_entered(body):
	if body.is_in_group("Boss"):
		body.damage(35)
		queue_free()
	elif body.is_in_group("Enemy"):
		body.damage(35)
	pass
